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

    def options
      render nothing: true, status: 200
      # if params[:id]
      #   resource = resource_class.find(params[:id])
      # end
    end

    protected

    # def resource_class
    # end

    # def skdljflkjy
    # end
  end
end

if defined? ActionController::Base
  ActionController::Base.class_eval do
    include CanTable::ControllerInclusion
    include CanTable::OptionsAction
  end
end
