class Appointment < ApplicationRecord
  belongs_to :user
  validates :appointment_id, presence: true, uniqueness: true
end
