require 'rails_helper'

describe 'Visitor event request' do
  context 'create' do
    xit 'without authorization' do
      owner = Owner.create!(name: 'Splinter', email: 'splinter@email.com', password: 'password')

      Buffet.create!(brand_name: 'Teenage Mutant Ninja Turtles', corporate_name: 'TMNT Splinter LTDA',
                     registration_number: '88392017000182', phone: '11912341234',
                     email: 'contato@tmntsplinter.com', address: 'Rua Estados Unidos, 1030 - Jardins',
                     city: 'São Paulo', state: 'SP', zip_code: '01234123',
                     description: 'Melhor Buffet da região. Cowabunga', payment: 'PIX, Cartão de Débito', owner:)

      post(events_path, params: { event: { name: 'Troca via request' } })

      expect(response).to redirect_to root_path
    end
  end

  context 'update' do
  end

  context 'delete' do
  end
end
