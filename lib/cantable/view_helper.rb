module CanTable
  module ViewHelpers
    include CanTable::ControllerInclusion
    def include_operation_permissions(resource, json = nil)
      table = can_table(resource) # like this: [:create,:read]
      operations = table.map do |action|
        {"method" => HTTP_VERBS[action]}
      end
      if json
        json.operation operations
      else
        operations
      end
    end
  end
end

if defined? ActionView::Base
  ActionView::Base.send(:include, CanTable::ViewHelpers)
end
