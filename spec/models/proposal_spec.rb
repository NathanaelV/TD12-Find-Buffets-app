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

  it 'validate fields' do
    proposal = Proposal.new(cost: -1, validate_date: 1.day.ago)

    proposal.valid?

    expect(proposal.errors.full_messages).to include 'Valor final deve ser positivo'
    expect(proposal.errors.full_messages).to include 'Data de expiração deve ser futura'
    expect(proposal.errors.full_messages).not_to include 'Data de expiração não pode ficar em branco'
    expect(proposal.errors.full_messages).not_to include 'Valor final não pode ficar em branco'
  end
end
