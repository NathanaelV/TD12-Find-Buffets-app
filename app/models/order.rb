class Order < ApplicationRecord
  belongs_to :buffet
  belongs_to :customer
  belongs_to :event

  validates :event_date, :people, :details, :address, :buffet_id, :customer_id, :event_id, presence: true
  validate :event_date_furute, :people_positive

  before_validation :generate_code, on: :create

  enum status: { pending: 0, approved: 5, canceled: 9 }

  def generate_code
    self.code = SecureRandom.alphanumeric(8).upcase
  end

  private

  def event_date_furute
    return if event_date && event_date > Date.today

    errors.add(:event_date, 'deve ser futura')
  end

  def people_positive
    return if people&.positive?

    errors.add(:people, 'deve ser positivo')
  end
end
