class EventCost < ApplicationRecord
  belongs_to :event

  validates :description, :minimum, :additional_per_person, :overtime, presence: true
end
