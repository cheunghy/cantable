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
      self.response_body = "some good stuff, haha"
#      render nothing: true, status: 200
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
  end

  ActionController::Base.descendants.each do |descendant|
    descendant.class_eval do
      include CanTable::OptionsAction
    end
  end

  ActionController::Base.instance_eval do
    def inherited(klass)
      klass.class_eval do
        include CanTable::OptionsAction
      end
    end
  end

end
