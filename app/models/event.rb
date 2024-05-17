class Event < ApplicationRecord
  belongs_to :buffet
  has_many :event_costs

  validates :name, :description, :min_people, :max_people, :duration, :menu, :buffet_id, presence: true
end
