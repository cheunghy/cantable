require 'cancancan'
require_relative 'exception'
module CanTable
  module ControllerInclusion
    HTTP_VERBS = {
      create: "POST",
      read: "GET",
      update: "PATCH",
      destroy: "DELETE",
      index: "GET"
    }

    def can_table(resource)
      table = []
      if resource.class == Class
        actions = [:create, :index]
      else
        actions = [:create, :read, :update, :destroy]
      end
      actions.map do |action|
        table << action if can? action, resource
      end
      table
    end

  end

  module OptionsAction
    HTTP_VERBS = {
      create: "POST",
      read: "GET",
      update: "PATCH",
      destroy: "DELETE",
      index: "GET"
    }
    public

    def operation
      resource = find_resource
      table = can_table(resource)
      set_options_header(table)
      render nothing: true, status: :ok
    end

    protected

    def set_options_header(table)
      allow_methods = table.map { |m| HTTP_VERBS[m] }.join(', ')
      headers['Allow'] = allow_methods
    end

    def resource_class
      controller_name.classify.constantize
    rescue NameError => e
      return nil
    end

    def find_resource
      if !resource_class
        raise ResourceClassNotFoundError, "Resource Class \"#{
controller_name.classify}\" not found"
      end
      if params[:id]
        resource = resource_class.find(params[:id])
      else
        resource = resource_class
      end
    end
  end
end

if defined? ActionController::Base

  ActionController::Base.class_eval do
    include CanTable::ControllerInclusion
  end

  ActionController::Base.descendants.each do |descendant|
    descendant.class_eval do
      include CanTable::OptionsAction
    end
  end
  if ActionController::Base.method_defined? :inherited
    ActionController::Base.instance_eval do
      alias_method :inherited_old, :inherited
      def inherited(klass)
        klass.class_eval do
          include CanTable::OptionsAction
          inherited_old(klass)
        end
      end
    end
  else
    ActionController::Base.instance_eval do
      def inherited(klass)
        klass.class_eval do
          include CanTable::OptionsAction
        end
      end
    end
  end
end
