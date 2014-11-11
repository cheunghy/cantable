require 'cancancan'
module CanTable
  module ControllerInclusion
    include CanCan::ControllerAdditions
    def can_table(resource)
      table = []
      actions = [:create, :read, :update, :destory]
      actions.map do |action|
        table << action if can? action, resource
      end
      table
    end

  end

  module OptionsAction

    public

    def operation
      if !resource_class
        self.response_body = "Bad Stuff Happens."
      end
      if params[:id]
        resource = resource_class.find(params[:id])
      else
        resource = resource_class
      end
      self.response_body = can_table(resource)
      # if params[:id]
      #   resource = resource_class.find(params[:id])
      # else
      #   resource = resource_class
      # end

    end

    protected

    def resource_class
      controller_name.classify.constantize
    end

    # def skdljflkjy
    # end
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
      def inherited(klass)
        klass.class_eval do
          include CanTable::OptionsAction
        end
      end
    end
  else
    ActionController::Base.instance_eval do
      alias_method :inherited_old, :inherited
      def inherited(klass)
        klass.class_eval do
          include CanTable::OptionsAction
          inherited_old(klass)
        end
      end
    end
  end
end
