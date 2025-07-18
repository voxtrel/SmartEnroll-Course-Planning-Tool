require "test_helper"

class StudentsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get students_url(format: :html)
    assert_response :success
  end

  test "should create student" do
    assert_difference("Student.count") do
      post students_url, params: { student: { name: "Test Student", email: "test@example.com", credits_earned: 10, password: "password", password_confirmation: "password", major: "Computer Science" } }
    end
    assert_redirected_to root_path
  end

  test "should get edit" do
    student = students(:one)
    get edit_student_url(student, format: :html)
    assert_response :success
  end

  test "should update student" do
    student = students(:one)
    patch student_url(student), params: { student: { name: "Updated Name" } }, as: :json

    assert_response :success

    json_response = JSON.parse(response.body)
    assert_equal true, json_response["success"]
    assert_equal "Updated Name", json_response["student"]["name"]
  end


  test "should destroy student" do
    student = students(:one)
    student.user_schedules.destroy_all # Remove dependencies
    assert_difference("Student.count", -1) do
      delete student_url(student)
    end
    assert_redirected_to students_url
  end
end
