require "test_helper"

class AdminControllerTest < ActionDispatch::IntegrationTest
  
  setup do
    @admin = User.find_by(role: :admin)
  end

  test "should get dashboard" do
    post login_url, params: {
      email: @admin.email,
      password: "Kar_elin@12034"
    }

    get admin_dashboard_url
    assert_response :success
  end
end
