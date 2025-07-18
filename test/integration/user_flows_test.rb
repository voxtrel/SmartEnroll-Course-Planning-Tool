require "test_helper"

class UserFlowsTest < ActionDispatch::IntegrationTest
  test "user can sign up" do
    get new_student_path
    assert_response :success

    post students_path, params: {
      student: {
        name: "John Doe",
        email: "johndoe@example.com",
        password: "securepassword",
        password_confirmation: "securepassword",
        major: "Computer Science"
      }
    }

    assert_response :redirect
    follow_redirect!

    assert_response :success
    assert_match "Log in", response.body

    assert Student.exists?(email: "johndoe@example.com")
  end
end
