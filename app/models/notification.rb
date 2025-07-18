class Notification < ApplicationRecord
    belongs_to :student

    validates :message, presence: true
end
