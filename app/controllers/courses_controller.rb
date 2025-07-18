class CoursesController < ApplicationController
  include ScheduleViewHelper
  before_action :set_course, only: %i[show edit update destroy]
  before_action :set_dropdown_terms, only: [ :index, :new, :create, :edit, :update ]

  def index
    @term = params[:term] # get the term from URL params
    @courses = Course.all

    # Filter by selected term
    @courses = @courses.where(term: @term) if @term.present?

    # Search filter
    if params[:search].present?
      search_term = "%#{params[:search].downcase}%"
      @courses = @courses.where("LOWER(class_name) LIKE ?", search_term)
    end

    # Recommended courses filter
    if params[:recommended] == "true" && current_student
      @courses = @courses.where(major: current_student.major)
    end

    if params[:low_demand] == "true"
      @courses = @courses.where("volume < capacity")
    end

    # Filter for days of the week
    if params[:day].present?
      day_param = params[:day].downcase

      case day_param
      when "mon"
        @courses = @courses.where(mon: true)
      when "tue"
        @courses = @courses.where(tue: true)
      when "wed"
        @courses = @courses.where(wed: true)
      when "thu"
        @courses = @courses.where(thu: true)
      when "fri"
        @courses = @courses.where(fri: true)
      end
    end
  end

  def show
  end

  def new
    @course = Course.new
    # @dropdown_terms is set by the before_action
  end

  def enroll
    course = Course.find(params[:id])
    current_student = Student.find(session[:student_id]) # Ensure user is logged in
  
    # Check if the student is already enrolled
    if current_student.courses.include?(course)
      flash[:notice] = "You're already enrolled in this course!"
      redirect_to courses_path(term: course.term) and return
    end
  
    # Check if the course has a prerequisite
    if course.prerequisite.present?
      # Get all completed courses for the student
      completed_courses = current_student.user_schedules.where(status: "Planned").pluck(:course_id)
  
      # Ensure the prerequisite course is completed
      prerequisite_course = Course.find_by(class_name: course.prerequisite)
      if prerequisite_course && !completed_courses.include?(prerequisite_course.id)
        flash[:alert] = "You cannot enroll in #{course.class_name} because you have not completed the prerequisite: #{course.prerequisite}."
        redirect_to courses_path(term: course.term) and return
      end
    end
  
    # Enroll the student by creating a new UserSchedule entry
    UserSchedule.create!(
      student_id: current_student.id,
      course_id: course.id,
      term: course.term,
      status: "Planned"
    )
  
    course.increment!(:volume)
  
    flash[:notice] = "Successfully enrolled in #{course.class_name} for #{course.term}!"
    redirect_to courses_path(term: course.term, day: params[:day], search: params[:search], recommended: params[:recommended])
  end
  
  def unenroll
    course = Course.find(params[:id])
    current_student.courses.delete(course)
    
 
    course.decrement!(:volume) if course.volume > 0
    
    redirect_to schedule_view_index_path(term: course.term), notice: "You have been unenrolled from #{course.class_name}."
  end
  

  def create
    @course = Course.new(course_params)
    if @course.save
      # Send notification to every user upon creation of the course
      send_notification_to_all_users(@course, action: "created")
      redirect_to admin_dashboard_path, notice: "Course successfully created."
    else
      flash.now[:alert] = "Error creating course. Please check the form."
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @course.update(course_params)
      # Send notification to every user upon update of the course
      send_notification_to_all_users(@course, action: "updated")
      redirect_to admin_dashboard_path, notice: "Course was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @course = Course.find(params[:id])
    @course.destroy
    redirect_to admin_dashboard_path, notice: "Course was successfully deleted."
  end

  private

  def set_course
    @course = Course.find(params[:id])
  end

  def set_dropdown_terms
    @dropdown_terms = build_term_dropdown
  end

  def course_params
    params.require(:course).permit(:CRN, :class_name, :professor, :term, :credits, :class_time, :end_time, :prerequisite, :status, :capacity, :major, :mon, :tue, :wed, :thu, :fri)
  end

  def send_notification_to_all_users(course, action:)
    message = case action
    when "created"
      "New course created: #{course.class_name}"
    when "updated"
      "Course updated: #{course.class_name}"
    else
      "Course #{course.class_name} has been #{action}"
    end
  
    Student.where(major: course.major).find_each do |student|
      Notification.create!(student: student, message: message)
      # Use the attribute accessor (student[:notifications]) to get the DB column value,
      # then update it directly to avoid conflict with the association.
      new_count = student[:notifications].to_i + 1
      student.update_column(:notifications, new_count)
    end
  end  
end
