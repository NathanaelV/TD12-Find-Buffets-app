class Proposal < ApplicationRecord
  belongs_to :order
  belongs_to :event
  belongs_to :event_cost
  belongs_to :customer

  validates :cost, :validate_date, :payment, presence: true
  validate :cost_positive, :validate_date_future

  enum status: { sent: 0, accepted: 5, declined: 9 }

  def proposal_expired?
    validate_date < Date.today
  end

  private

  def cost_positive
    return if cost&.positive?

    errors.add(:cost, 'deve ser positivo')
  end

  def validate_date_future
    return if validate_date && validate_date > Date.today

    errors.add(:validate_date, 'deve ser futura')
  end
end
