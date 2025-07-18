class AddStatusAndPrerequisiteToCourses < ActiveRecord::Migration[8.0]
  def change
    add_column :courses, :status, :string
    add_column :courses, :prerequisite, :string
  end
end
