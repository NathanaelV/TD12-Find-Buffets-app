require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'presence' do
    it 'mandatory' do
      event = Event.new

      event.valid?

      expect(event.errors).to include :name
      expect(event.errors).to include :description
      expect(event.errors).to include :min_people
      expect(event.errors).to include :max_people
      expect(event.errors).to include :duration
      expect(event.errors).to include :menu
      expect(event.errors).to include :buffet_id
    end
  end

  it 'validate numeric fields' do
    event = Event.new(min_people: -1, max_people: -1, duration: -1)

    event.valid?

    expect(event.errors.full_messages).to include 'Mínimo de pessoas deve ser positivo'
    expect(event.errors.full_messages).to include 'Máximo de pessoas deve ser positivo'
    expect(event.errors.full_messages).to include 'Duração deve ser positivo'
    expect(event.errors.full_messages).not_to include 'Mínimo de pessoas não pode ficar em branco'
    expect(event.errors.full_messages).not_to include 'Máximo de pessoas não pode ficar em branco'
    expect(event.errors.full_messages).not_to include 'Duração não pode ficar em branco'
  end
end
