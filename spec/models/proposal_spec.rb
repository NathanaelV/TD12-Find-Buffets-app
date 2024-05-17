require 'rails_helper'

RSpec.describe Proposal, type: :model do
  describe 'presence' do
    it 'mandatory' do
      proposal = Proposal.new

      proposal.valid?

      expect(proposal.errors).to include :cost
      expect(proposal.errors).to include :validate_date
      expect(proposal.errors).to include :payment
    end
  end

  xit 'status need to be created as sent' do
    
  end

  describe 'price_change' do
    xit 'default zero' do
      
    end
    
    xit 'cannot be negative' do
      
    end
  end
end
