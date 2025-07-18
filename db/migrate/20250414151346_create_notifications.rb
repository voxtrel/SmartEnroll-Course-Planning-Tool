class CreateNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :notifications do |t|
      t.references :student, null: false, foreign_key: true
      t.string :message, null: false
      t.boolean :read, default: false, null: false

      t.timestamps
    end
  end
end
