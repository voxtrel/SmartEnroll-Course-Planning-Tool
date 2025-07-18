require "application_system_test_case"

class UserSignupTest < ApplicationSystemTestCase
  test "user can sign up successfully" do
    visit new_student_path

    fill_in "Full Name", with: "John Doe"
    fill_in "Email Address", with: "john@example.com"
    select "Computer Science", from: "Major"
    fill_in "Password", with: "securepassword"
    fill_in "Confirm Password", with: "securepassword"

    click_on "Sign Up"

    assert_current_path root_path
  end
end
