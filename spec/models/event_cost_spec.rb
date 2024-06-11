require 'rails_helper'

RSpec.describe EventCost, type: :model do
  describe 'presence' do
    it 'mandatory' do
      event_cost = EventCost.new

      event_cost.valid?

      expect(event_cost.errors).to include :description
      expect(event_cost.errors).to include :minimum
      expect(event_cost.errors).to include :additional_per_person
      expect(event_cost.errors).to include :overtime
    end
  end

  it 'validate fields' do
    event_cost = EventCost.new(minimum: -1, additional_per_person: -1, overtime: -1)

    event_cost.valid?

    expect(event_cost.errors.full_messages).to include 'Valor mínimo deve ser positivo'
    expect(event_cost.errors.full_messages).to include 'Valor adicional por pessoa deve ser positivo'
    expect(event_cost.errors.full_messages).to include 'Hora extra deve ser positivo'
    expect(event_cost.errors.full_messages).not_to include 'Valor mínimo não pode ficar em branco'
    expect(event_cost.errors.full_messages).not_to include 'Valor adicional por pessoa não pode ficar em branco'
    expect(event_cost.errors.full_messages).not_to include 'Hora extra não pode ficar em branco'
  end
end
