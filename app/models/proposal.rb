class Proposal < ApplicationRecord
  belongs_to :order
  belongs_to :event
  belongs_to :event_cost
end
