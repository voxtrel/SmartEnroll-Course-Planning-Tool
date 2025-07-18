class ScheduleViewController < ApplicationController
  def index
    @student = Student.find(session[:student_id])  # Find the student from session

    # Get the current term based on the date or user selection
    @term = params[:term] || next_term  # Check if there's a selected term, otherwise use the next_term

    # Filter enrolled courses to only include those for the selected term
    @enrolled_courses = @student.courses.where(term: @term)

    # Only show UserSchedules that match the selected term
    @user_schedules = @student.user_schedules.includes(:course).select { |us| us.course.term == @term }

    # Build the dropdown terms for past and future terms
    @dropdown_terms = build_term_dropdown
  end

  def create
    student = Student.find(session[:student_id])
    course = Course.find(params[:course_id])

    UserSchedule.create!(student_id: student.id, course_id: course.id, term: course.term)

    redirect_to schedule_view_index_path, notice: "Course added to your schedule for #{course.term}!"
  end

  def destroy
    user_schedule = UserSchedule.find(params[:id])
    user_schedule.destroy

    redirect_to schedule_view_index_path, notice: "Course removed from your schedule."
  end

  private

  def next_term
    today = Date.today
    year = today.year

    case today
    when Date.new(year, 1, 1)..Date.new(year, 5, 15)
      "Summer #{year}"
    when Date.new(year, 5, 16)..Date.new(year, 8, 10)
      "Fall #{year}"
    else
      "Spring #{year + 1}"
    end
  end

  # Build the dropdown list of terms
  def build_term_dropdown
    current_year = Date.today.year
    seasons = [ "Spring", "Summer", "Fall" ]

    terms = []

    # Generate terms for the next two years and the previous terms
    (current_year - 1..current_year + 1).each do |year|
      seasons.each do |season|
        terms << "#{season} #{year}"
      end
    end

    # Sort terms by year and season (Spring, Summer, Fall)
    terms.sort_by { |term| [ term.split.last.to_i, seasons.index(term.split.first) ] }
  end
end
