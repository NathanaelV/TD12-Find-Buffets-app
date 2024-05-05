require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe '#valid?' do
    it 'CPF must be mandatory' do
      customer = Customer.new

      customer.valid?
      customer_errors = customer.errors.full_messages

      expect(customer_errors).to include 'CPF não pode ficar em branco'
    end

    it 'valid CPF' do
      valid_cpf = CPF.generate
      customer = Customer.new(name: 'Donatello', cpf: valid_cpf, email: 'donatello@email.com', password: 'password')

      result = customer.valid?

      expect(result).to eq true
    end

    it 'invalid CPF' do
      valid_cpf = '000.000.000-00'
      customer = Customer.new(name: 'Donatello', cpf: valid_cpf, email: 'donatello@email.com', password: 'password')

      customer.valid?
      customer_errors = customer.errors.full_messages

      expect(customer_errors).to include 'CPF deve ser válido.'
    end
  end
end
