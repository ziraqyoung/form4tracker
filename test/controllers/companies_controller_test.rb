require "test_helper"

class CompaniesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get companies_url
    assert_response :success
  end
end
