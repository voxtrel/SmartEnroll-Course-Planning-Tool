class AddTitleAndBodyToNotifications < ActiveRecord::Migration[8.0]
  def change
    add_column :notifications, :title, :string
    add_column :notifications, :body, :string
  end
end
