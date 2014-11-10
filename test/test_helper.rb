# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require "rails/test_help"

Rails.backtrace_cleaner.remove_silencers!

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

# Load fixtures from the engine
if ActiveSupport::TestCase.method_defined?(:fixture_path=)
  ActiveSupport::TestCase.fixture_path = File.expand_path("../fixtures", __FILE__)
end

module ActionController::TestCase::Behavior
  def options(action, *args)
    process(action, "OPTIONS", *args)
  end
end

module ActionDispatch::Integration::RequestHelpers
  def options(path, parameters = nil, headers_or_env = nil)
    process :options, path, parameters, headers_or_env
  end
end
