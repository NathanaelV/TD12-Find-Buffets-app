class Buffet < ApplicationRecord
  belongs_to :owner

  has_many :events

  def state_city
    "#{state} - #{city}"
  end
end
