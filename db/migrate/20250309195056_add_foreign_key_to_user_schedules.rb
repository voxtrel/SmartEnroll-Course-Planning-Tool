class AddForeignKeyToUserSchedules < ActiveRecord::Migration[8.0]
  def change
    remove_foreign_key :user_schedules, :courses rescue nil

    add_foreign_key :user_schedules, :courses, column: :course_id, primary_key: "CRN"
  end
end
