class UserSchedule < ApplicationRecord
  # User Schedule maps a many to many relationship
  # A student can have many courses and a course can have many students
  belongs_to :student
  # Need to modify the foreign key so RoR knows we changed it to "CRN"
  belongs_to :course, foreign_key: "course_id", primary_key: "CRN"
  validates :term, presence: true
end
