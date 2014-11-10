module CanTable
  class MidnightOptions
    def initialize(app)
      @app = app
    end

    def call(env)
      return [200, {"Content-Type" => "text/html"}, ["Hello, World!"]] if env['REQUEST_METHOD'].eql? 'OPTIONS'
      @app.call(env)
    end
  end
end

