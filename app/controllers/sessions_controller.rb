class SessionsController < ApplicationController
  def new
  end

  def create
    # Try to log in as student first
    student = Student.find_by(email: params[:email])
    if student&.authenticate(params[:password])
      session[:student_id] = student.id
      redirect_to dashboard_path and return
    end

    # Try to log in as admin next
    admin = Admin.find_by(email: params[:email])
    if admin&.authenticate(params[:password])
      session[:admin_id] = admin.id
      redirect_to admin_dashboard_path and return
    end

    # If neither match, show alert
    flash[:alert] = "Invalid email or password"
    redirect_to root_path
  end

  def destroy
    session[:student_id] = nil
    session[:admin_id] = nil
    redirect_to root_path, notice: "Logged out successfully"
  end
end
