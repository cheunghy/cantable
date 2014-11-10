module CanTable
require 'pp'
  class MidnightOptions

    METHODS = ["GET", "POST", "PATCH", "DELETE"]

    def initialize(app)
      @app = app
    end

    def call(env)
      return parse(env) if env['REQUEST_METHOD'].eql? 'OPTIONS'
      @app.call(env)
    end

    def parse(env)
      route = env["action_dispatch.routes"]
      uri = env["REQUEST_URI"] # maybe ORIGINAL_FULLPATH?
      controller, action = nil, nil
      exception = nil
      params = nil
      METHODS.each do |method|
        begin
          params = route.recognize_path(uri, method: method)
        rescue ActionController::RoutingError => e
          exception = e
          next
        else
          env["REQUEST_METHOD"] = method
          break
        end
      end

      controller, action = params ? params.values_at(:controller, :action) : [nil, nil]
      raise exception if !controller

      params[:action] = 'options'
      action = 'options'
      router = route.instance_variable_get(:@router)
      req = router.instance_eval { request_class.new(env) }
      router.recognize(req) do |route, parameters|
        dispatcher = route.app

        env["REQUEST_METHOD"] = "OPTIONS"
        pp "Here Start"
        pp params
        pp "Here Stop"

        real_controller = dispatcher.controller(params, false)
        if real_controller
          env["action_dispatch.request.request_parameters"] = params
          dispatcher.instance_eval { dispatch(real_controller, action, env) }
        end
      end
    end
  end
end
