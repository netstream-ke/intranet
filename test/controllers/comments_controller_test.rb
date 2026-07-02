
require "test_helper"

class CommentsControllerTest < ActionDispatch::IntegrationTest
fixtures :tasks

  setup do
    @user = User.first
    @task = Task.first

    post login_url, params: {
      email: @user.email,
      password: "Kar_elin@12034"
    }
  end

  test "should create comment" do
    post task_comments_url(task_id: @task.id), params: {
      comment: {
        content: "Test comment"
      }
    }

    assert_response :redirect
  end
end
