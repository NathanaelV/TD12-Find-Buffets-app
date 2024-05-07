class Proposal < ApplicationRecord
  belongs_to :order
  belongs_to :event
  belongs_to :event_cost

  enum status: { sent: 0, accept: 5, declined: 9 }
end
