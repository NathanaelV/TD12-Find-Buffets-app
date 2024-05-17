require 'rails_helper'

RSpec.describe Buffet, type: :model do
  describe 'Create' do
    xit 'Owner cannot create a buffet if he already has one' do
    end
  end

  describe 'presence' do
    it 'mandatory' do
      buffet = Buffet.new

      buffet.valid?

      expect(buffet.errors).to include :brand_name
      expect(buffet.errors).to include :corporate_name
      expect(buffet.errors).to include :registration_number
      expect(buffet.errors).to include :phone
      expect(buffet.errors).to include :email
      expect(buffet.errors).to include :address
      expect(buffet.errors).to include :city
      expect(buffet.errors).to include :state
      expect(buffet.errors).to include :zip_code
      expect(buffet.errors).to include :payment
    end
  end
end
