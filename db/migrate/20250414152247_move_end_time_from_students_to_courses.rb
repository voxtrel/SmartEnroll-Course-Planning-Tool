class MoveEndTimeFromStudentsToCourses < ActiveRecord::Migration[8.0]
  def up
    add_column :courses, :end_time, :time unless column_exists?(:courses, :end_time)

    remove_column :students, :end_time, :time if column_exists?(:students, :end_time)
  end

  def down
    add_column :students, :end_time, :time unless column_exists?(:students, :end_time)

    remove_column :courses, :end_time, :time if column_exists?(:courses, :end_time)
  end
end
