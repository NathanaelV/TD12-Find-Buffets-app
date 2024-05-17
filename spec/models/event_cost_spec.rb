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
end
