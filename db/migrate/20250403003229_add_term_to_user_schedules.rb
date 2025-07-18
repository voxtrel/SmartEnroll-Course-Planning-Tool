class AddTermToUserSchedules < ActiveRecord::Migration[8.0]
  def change
    add_column :user_schedules, :term, :string
  end
end
