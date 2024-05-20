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

  xit 'validate fields' do
    # Cost needs to be positive. Try it with negative number
  end
end
