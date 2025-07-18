class AdminsController < ApplicationController
    def index
      @admins = Admin.all
    end

    def create
      @admin = Admin.new(admin_params)
      if @admin.save
        redirect_to admins_path
      else
        render :new
      end
    end

    def update
      @admin = Admin.find(params[:id])
      if @admin.update(admin_params)
        redirect_to admins_path
      else
        render :edit
      end
    end

    def admins_dashboard
      @courses = Course.all
    end

    def destroy
      @admin = Admin.find(params[:id])
      @admin.destroy
      redirect_to admins_path
    end

    private

    def admin_params
      params.require(:admin).permit(:name, :email)
    end
end
