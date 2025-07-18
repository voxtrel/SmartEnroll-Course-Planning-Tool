class Student < ApplicationRecord
  # Validations
  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  validates :credits_earned, numericality: { greater_than_or_equal_to: 0 }
  validates :major, presence: true, on: :create  # Only required when creating a student
  validates :password, presence: true, confirmation: true, if: :password_required?

  # Associations
  has_many :user_schedules
  has_many :courses, through: :user_schedules
  has_many :notifications, dependent: :destroy

  # Secure password handling
  has_secure_password

  def full_name
    name
  end

  private

  def password_required?
    new_record? || password.present?  # Require password only for new records or when explicitly changing it
  end
end
