require "test_helper"

class FeedControllerTest < ActionDispatch::IntegrationTest
  test "renders feed" do
    get root_path
    assert_response :ok
  end
end
