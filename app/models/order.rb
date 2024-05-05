class Order < ApplicationRecord
  belongs_to :buffet
  belongs_to :customer
  belongs_to :event

  before_validation :generate_code, on: :create

  enum status: { pending: 0, approved: 5, canceled: 9 }

  def generate_code
    self.code = SecureRandom.alphanumeric(8).upcase
  end
end
