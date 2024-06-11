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
end
