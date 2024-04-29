class Event < ApplicationRecord
  belongs_to :buffet
  has_many :event_costs
end
