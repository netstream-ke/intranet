ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Load all fixtures
  fixtures :all
end

class ActionDispatch::IntegrationTest
  def sign_in_as(user)
    post login_url, params: {
      email: user.email,
      password: "Kar_elin@12034"
    }
  end
end
