require "test_helper"

class ChartsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get charts_url
    assert_response :success
  end
end
