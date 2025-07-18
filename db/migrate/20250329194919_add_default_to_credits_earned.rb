class AddDefaultToCreditsEarned < ActiveRecord::Migration[6.1]
  def change
    change_column_default :students, :credits_earned, 0
  end
end
