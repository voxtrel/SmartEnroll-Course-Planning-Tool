# test/models/course_test.rb
require "test_helper"
require "time"  # Ensure Time is available for handling class_time

class CourseTest < ActiveSupport::TestCase
  # Test if a Course is valid with all required attributes
  test "should be valid with valid attributes" do
    course = Course.new(
      CRN: 203,
      class_name: "Computer Networks",
      professor: "Dr. Adams",
      term: "Spring 2024",
      credits: 4,
      class_time: Time.parse("14:00"),
      end_time: "12:00:00",
      status: "Open",
      major: "Computer Science",
      prerequisite: "None"
    )
    assert course.valid?, "Course should be valid with all attributes"
  end

  # Test if a Course is invalid without a CRN
  test "should be invalid without a CRN" do
    course = Course.new(
      CRN: nil,
      class_name: "Computer Networks",
      professor: "Dr. Adams",
      term: "Spring 2024",
      credits: 4,
      class_time: Time.parse("14:00"),
      end_time: "12:00:00",
      status: "Open",
      major: "Computer Science",
      prerequisite: "None"
    )
    assert_not course.valid?, "Course should be invalid without a CRN"
  end

  # Test if a Course is invalid without a class_name
  test "should be invalid without a class_name" do
    course = Course.new(
      CRN: 203,
      class_name: nil,
      professor: "Dr. Adams",
      term: "Spring 2024",
      credits: 4,
      class_time: Time.parse("14:00"),
      end_time: "12:00:00",
      status: "Open",
      major: "Computer Science",
      prerequisite: "None"
    )
    assert_not course.valid?, "Course should be invalid without a class_name"
  end

  # Test if a Course is invalid without a professor
  test "should be invalid without a professor" do
    course = Course.new(
      CRN: 203,
      class_name: "Computer Networks",
      professor: nil,
      term: "Spring 2024",
      credits: 4,
      class_time: Time.parse("14:00"),
      end_time: "12:00:00",
      status: "Open",
      major: "Computer Science",
      prerequisite: "None"
    )
    assert_not course.valid?, "Course should be invalid without a professor"
  end

  # Test if a Course is invalid without a term
  test "should be invalid without a term" do
    course = Course.new(
      CRN: 203,
      class_name: "Computer Networks",
      professor: "Dr. Adams",
      term: nil,
      credits: 4,
      class_time: Time.parse("14:00"),
      end_time: "12:00:00",
      status: "Open",
      major: "Computer Science",
      prerequisite: "None"
    )
    assert_not course.valid?, "Course should be invalid without a term"
  end

  # Test if a Course is invalid without credits
  test "should be invalid without credits" do
    course = Course.new(
      CRN: 203,
      class_name: "Computer Networks",
      professor: "Dr. Adams",
      term: "Spring 2024",
      credits: nil,
      class_time: Time.parse("14:00"),
      end_time: "12:00:00",
      status: "Open",
      major: "Computer Science",
      prerequisite: "None"
    )
    assert_not course.valid?, "Course should be invalid without credits"
  end

  # Test if a Course is invalid without class_time
  test "should be invalid without class_time" do
    course = Course.new(
      CRN: 203,
      class_name: "Computer Networks",
      professor: "Dr. Adams",
      term: "Spring 2024",
      credits: 4,
      class_time: nil,
      end_time: "12:00:00",
      status: "Open",
      major: "Computer Science",
      prerequisite: "None"
    )
    assert_not course.valid?, "Course should be invalid without class_time"
  end

  # Test that CRN must be unique
  test "should be invalid if CRN is not unique" do
    # Ensure that the database is clean before the test
    Course.create!(
      CRN: 203,
      class_name: "Computer Networks",
      professor: "Dr. Adams",
      term: "Spring 2024",
      credits: 4,
      class_time: Time.parse("14:00"),
      end_time: "12:00:00",
      status: "Open",
      major: "Computer Science",
      prerequisite: "None"
    )

    course = Course.new(
      CRN: 203, # Same CRN as the existing record
      class_name: "Database Systems",
      professor: "Dr. Brown",
      term: "Fall 2024",
      credits: 3,
      class_time: Time.parse("16:00"),
      end_time: "12:00:00",
      status: "Open",
      major: "Computer Science",
      prerequisite: "None"
    )

    assert_not course.valid?, "Course should be invalid with a duplicate CRN"
  end
end
