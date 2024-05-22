require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'presence' do
    it 'mandatory' do
      order = Order.new

      order.valid?

      expect(order.errors).to include :event_date
      expect(order.errors).to include :people
      expect(order.errors).to include :details
      expect(order.errors).to include :address
      expect(order.errors).to include :buffet_id
      expect(order.errors).to include :customer_id
      expect(order.errors).to include :event_id
      expect(order.code).not_to be_nil
      expect(order.status).to eq 'pending'
    end
  end

  it 'validate fields' do
    order = Order.new(event_date: 1.day.ago.strftime('%d/%m/%Y'), people: -1)

    order.valid?

    expect(order.errors.full_messages).to include 'Data do evento deve ser futura'
    expect(order.errors.full_messages).to include 'Quantidade de pessoas deve ser positivo'
    expect(order.errors.full_messages).not_to include 'Data do evento não pode ficar em branco'
    expect(order.errors.full_messages).not_to include 'Quantidade de pessoas não pode ficar em branco'
  end
end
