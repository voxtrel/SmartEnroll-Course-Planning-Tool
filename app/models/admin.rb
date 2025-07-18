class Admin < ApplicationRecord
  has_secure_password  # Enables password encryption

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 6 }, if: -> { password.present? }
  validates :role, presence: true, inclusion: { in: %w[superadmin moderator] }
end
