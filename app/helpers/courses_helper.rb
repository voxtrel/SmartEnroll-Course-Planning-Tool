module CoursesHelper
  # Returns the enrollment status for a course for the current student.
  # Assumes that the courses table uses CRN as its primary key and that
  # current_student.user_schedules has records where course_id matches course.CRN.
  def enrollment_status_for(course)
    return nil unless current_student
    current_student.user_schedules.find_by(course_id: course.CRN)&.status
  end

  # Returns the appropriate HTML for the enrollment action.
  # If the course is already planned or taken, it shows a red box with that text.
  # Otherwise, it shows the link with the given text (defaulting to 'Enroll').
  def enrollment_action_for(course, text: 'Enroll')
    status = enrollment_status_for(course)
    if status.present?
      if status == "Planned"
        content_tag(:span, "Planned", class: "enroll-button planned")
      elsif status == "Taken"
        content_tag(:span, "Taken", class: "enroll-button taken")
      else
        link_to text, enroll_course_path(course), method: :get, class: "enroll-button"
      end
    else
      link_to text, enroll_course_path(course), method: :get, class: "enroll-button"
    end
  end
end