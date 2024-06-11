class Event < ApplicationRecord
  belongs_to :buffet
  has_many :event_costs

  validates :name, :description, :min_people, :max_people, :duration, :menu, :buffet_id, presence: true
  validate :min_people_positive, :max_people_positive, :duration_positive

  private

  def min_people_positive
    return if min_people.to_i.positive?

    errors.add(:min_people, ' deve ser positivo')
  end

  def max_people_positive
    return if max_people.to_i.positive?

    errors.add(:max_people, ' deve ser positivo')
  end

  def duration_positive
    return if duration.to_i.positive?

    errors.add(:duration, ' deve ser positivo')
  end
end
