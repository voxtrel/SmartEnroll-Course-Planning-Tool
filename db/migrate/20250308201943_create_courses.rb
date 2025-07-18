class CreateCourses < ActiveRecord::Migration[8.0]
  def change
    create_table :courses, id: false do |t|
      t.integer :CRN, primary_key: true
      t.string :class_name, null: false
      t.string :professor, null: false
      t.string :term, null: false
      t.integer :credits, null: false
      t.time :class_time, null: false

      t.timestamps
    end
  end
end
