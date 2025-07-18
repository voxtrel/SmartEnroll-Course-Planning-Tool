class DashboardController < ApplicationController
  def index
    @student = Student.first
  end
end
