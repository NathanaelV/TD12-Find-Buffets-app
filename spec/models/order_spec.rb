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
    end
  end

  xit 'code needs to be created' do
  end

  xit 'status needs to be created as pending' do
  end
end
