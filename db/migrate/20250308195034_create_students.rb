class CreateStudents < ActiveRecord::Migration[8.0]
  def change
    create_table :students do |t|
      t.string :email
      t.string :name
      t.string :password_digest
      t.integer :credits_earned

      t.timestamps
    end
  end
end
