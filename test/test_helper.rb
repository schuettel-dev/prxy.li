ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

class ActionDispatch::IntegrationTest
  def sign_in!
    post sessions_path, params: { password: "pass-test" }
    follow_redirect!

    assert_response :success
  end

  def sign_out!
    delete sessions_path
    follow_redirect!

    assert_response :success
  end
end
