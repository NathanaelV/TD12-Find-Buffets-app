class Proposal < ApplicationRecord
  belongs_to :order
  belongs_to :event
  belongs_to :event_cost
  belongs_to :customer

  enum status: { sent: 0, accepted: 5, declined: 9 }

  def proposal_expired?
    validate_date < Date.today
  end
end
