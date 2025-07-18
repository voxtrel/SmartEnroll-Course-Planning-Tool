class AddDayBooleansToCourses < ActiveRecord::Migration[8.0]
  def change
    add_column :courses, :mon, :boolean, default: false
    add_column :courses, :tue, :boolean, default: false
    add_column :courses, :wed, :boolean, default: false
    add_column :courses, :thu, :boolean, default: false
    add_column :courses, :fri, :boolean, default: false
  end
end
