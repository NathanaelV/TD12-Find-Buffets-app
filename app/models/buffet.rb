class Buffet < ApplicationRecord
  belongs_to :owner

  has_many :events
end
