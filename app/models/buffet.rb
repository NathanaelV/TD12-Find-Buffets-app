class Buffet < ApplicationRecord
  belongs_to :owner

  has_many :events

  validates :brand_name, :corporate_name, :registration_number, :phone, :email, :address, :city, :state, :zip_code,
            :payment, presence: true

  def state_city
    "#{state} - #{city}"
  end
end
