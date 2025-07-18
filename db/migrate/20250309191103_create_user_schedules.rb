class CreateUserSchedules < ActiveRecord::Migration[8.0]
  def change
    create_table :user_schedules do |t|
      t.references :student, null: false, foreign_key: true
      t.integer :course_id, null: false
      t.string :status

      t.timestamps
    end
   add_foreign_key :user_schedules, :courses, column: :course_id, primary_key: "CRN"
  end
end
