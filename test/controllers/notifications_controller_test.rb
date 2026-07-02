require "test_helper"

class NotificationsControllerTest < ActionDispatch::IntegrationTest
  fixtures :users

  setup do
    @user = users(:one)

    post login_url, params: {
      email: @user.email,
      password: "Kar_elin@12034"
    }
  end

  test "should get index" do
    get notifications_url
    assert_response :success
  end
end
