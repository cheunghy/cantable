require 'test_helper'

class OptionsTest < ActionDispatch::IntegrationTest
  test "it returns hello world for now" do
    options "/what/ever"
    assert_response :success
    assert_equal response.body, "Hello, World!"
  end
end
