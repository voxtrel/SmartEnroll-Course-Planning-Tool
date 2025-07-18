require "test_helper"

class StudentTest < ActiveSupport::TestCase
  # Setup a valid student to be used in multiple tests
  setup do
    @student = Student.new(
      email: "test@example.com",
      name: "John Doe",
      credits_earned: 30,
      password: "password",
      password_confirmation: "password",
      major: "Computer Science"
    )
  end

  # Test email presence and uniqueness
  test "should not save student without email" do
    @student.email = nil
    assert_not @student.save, "Saved the student without an email"
  end

  test "should not save student with duplicate email" do
    duplicate_student = @student.dup
    @student.save
    assert_not duplicate_student.save, "Saved the student with a duplicate email"
  end

  # Test name presence
  test "should not save student without name" do
    @student.name = nil
    assert_not @student.save, "Saved the student without a name"
  end

  # Test credits_earned presence and numericality
  test "should not save student with negative credits_earned" do
    @student.credits_earned = -1
    assert_not @student.save, "Saved the student with negative credits_earned"
  end

  test "should save student with valid credits_earned" do
    @student.credits_earned = 10
    assert @student.save, "Could not save the student with valid credits_earned"
  end

  # Test full_name method
  # test "should return full name" do
  #   @student.first_name = "John"
  #   @student.last_name = "Doe"
  #   assert_equal "John Doe", @student.full_name, "Full name is incorrect"
  # end

  # Test password presence and secure password handling
  test "should not save student without password" do
    @student.password = @student.password_confirmation = nil
    assert_not @student.save, "Saved the student without a password"
  end

  test "should save student with password" do
    assert @student.save, "Could not save the student with a password"
  end
end
