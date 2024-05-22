class EventCost < ApplicationRecord
  belongs_to :event

  validates :description, :minimum, :additional_per_person, :overtime, presence: true
  validate :minimum_positive, :additional_per_person_positive, :overtime_positive

  private

  def minimum_positive
    return if minimum.to_i.positive?

    errors.add(:minimum, 'deve ser positivo')
  end

  def additional_per_person_positive
    return if additional_per_person.to_i.positive?

    errors.add(:additional_per_person, 'deve ser positivo')
  end

  def overtime_positive
    return if overtime.to_i.positive?

    errors.add(:overtime, 'deve ser positivo')
  end
end
