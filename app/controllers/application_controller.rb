class ApplicationController < ActionController::Base
  helper_method :current_student, :logged_in?

  def current_student
    @current_student ||= Student.find_by(id: session[:student_id])
  end

  def logged_in?
    current_student.present?
  end
end
