class AddVolumeAndCapacityToCourses < ActiveRecord::Migration[6.1]
  def change
    add_column :courses, :volume, :integer, default: 0, null: false
    add_column :courses, :capacity, :integer, default: 0, null: false
  end
end
