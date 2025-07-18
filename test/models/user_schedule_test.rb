require "test_helper"

class UserScheduleTest < ActiveSupport::TestCase
  def setup
    @student = Student.create!(
      email: "test@student.com",
      name: "Test Student",
      password: "password",
      credits_earned: 0,
      major: "Computer Science"
    )

    @course = Course.create!(
      CRN: 12345,
      class_name: "Test Course",
      professor: "Test Professor",
      term: "Fall 2025",
      credits: 3,
      class_time: "10:00:00",
      end_time: "12:00:00",
      status: "Open",
      major: "Computer Science",
      prerequisite: "None"
    )

    @user_schedule = UserSchedule.create!(
      student: @student,
      course: @course,
      term: @course.term
    )
  end

  test "should create user_schedule with valid student and course associations" do
    assert @user_schedule.valid?, "UserSchedule should be valid with proper associations"
    assert_equal @student, @user_schedule.student, "Associated student should match"
    assert_equal @course, @user_schedule.course, "Associated course should match"
    assert_equal "Fall 2025", @user_schedule.term, "Term should match the course term"
  end

  test "should not be valid without a student" do
    invalid_schedule = UserSchedule.new(course: @course, term: @course.term)
    assert_not invalid_schedule.valid?, "UserSchedule should be invalid without a student"
  end

  test "should not be valid without a course" do
    invalid_schedule = UserSchedule.new(student: @student, term: @course.term)
    assert_not invalid_schedule.valid?, "UserSchedule should be invalid without a course"
  end
end
