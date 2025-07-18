Rails.application.routes.draw do
  # Root path
  root "home#index"

  # Authentication routes
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy", as: :logout
  get "/dashboard", to: "students#dashboard", as: :dashboard

  # Notifications as a top-level route
  get "notifications", to: "students#notifications", as: "notifications"

  # Health check
  get "up" => "rails/health#show", as: :rails_health_check

  # Resourceful routes
  resources :students

  resources :courses do
    member do
      get "enroll"
    end
  end

  resources :schedule_view, only: [ :index ]
  resources :admins

  get "admin/dashboard", to: "admins#admins_dashboard", as: "admin_dashboard"


  get "students/:id/edit_password", to: "students#edit_password", as: "edit_password"
  patch "students/:id/update_password", to: "students#update_password", as: "update_password"

  delete "/courses/:id/unenroll", to: "courses#unenroll", as: "unenroll_course"
  get "/students/:id", to: "students#show", as: "student_profile"

  delete "notifications/clear_all", to: "students#destroy_all_notifications", as: "clear_all_notifications"
  delete "notifications/:id", to: "students#destroy_notification", as: "notification"

end
