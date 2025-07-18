class Course < ApplicationRecord
  self.primary_key = "CRN"

  # Validations
  validates :CRN, presence: true, uniqueness: true, numericality: { only_integer: true }
  validates :class_name, presence: true
  validates :professor, presence: true
  validates :term, presence: true
  validates :credits, numericality: { greater_than: 0 }
  validates :class_time, presence: true
  validates :major, presence: true
  validates :status, presence: true, inclusion: { in: [ "Open", "Closed", "Waitlist" ] }
  validates :prerequisite, presence: true
  validates :end_time, presence: true


  # Associations
  has_many :user_schedules
  has_many :students, through: :user_schedules, dependent: :destroy

  # Instance Methods
  def full_course_name
    "#{class_name} (#{CRN}) - #{term}"
  end
  def normalize_prerequisite
    self.prerequisite = prerequisite&.strip&.downcase || ""
  end
end
