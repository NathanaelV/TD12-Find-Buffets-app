require 'rails_helper'

describe 'Register Buffet' do
  xit 'when owner already has a buffet' do
    owner = Owner.create!(name: 'Splinter', email: 'splinter@email.com', password: 'password')

    Buffet.create!(brand_name: 'Teenage Mutant Ninja Turtles', corporate_name: 'TMNT Splinter LTDA',
                   registration_number: '88392017000182', phone: '11912341234',
                   email: 'contato@tmntsplinter.com', address: 'Rua Estados Unidos, 1030 - Jardins',
                   city: 'São Paulo', state: 'SP', zip_code: '01234123',
                   description: 'Melhor Buffet da região. Cowabunga', payment: 'PIX, Cartão de Débito', owner:)

    buffet = { 'id' => 3,
               'brand_name' => 'Teen Titans',
               'corporate_name' => 'Justice League Teens',
               'registration_number' => '70849145000147',
               'phone' => '11900001111',
               'email' => 'contato@teentitans.com',
               'address' => 'Torre T, s/n - Ilha',
               'city' => 'Florianópolis',
               'state' => 'SC',
               'zip_code' => '88000-123',
               'description' => 'Batman é o melhor.',
               'payment' => 'PIX, Cartão de Débito, Cartão de Crédito',
               'owner_id' => 3,
               'created_at' => '2024-05-21T11:06:00.396Z',
               'updated_at' => '2024-05-21T11:06:00.396Z' }
  end

  xit 'customer cannot' do
  end

  xit 'visitor cannot register' do
    owner = Owner.create!(name: 'Splinter', email: 'splinter@email.com', password: 'password')

    Buffet.create!(brand_name: 'Teenage Mutant Ninja Turtles', corporate_name: 'TMNT Splinter LTDA',
                   registration_number: '88392017000182', phone: '11912341234',
                   email: 'contato@tmntsplinter.com', address: 'Rua Estados Unidos, 1030 - Jardins',
                   city: 'São Paulo', state: 'SP', zip_code: '01234123',
                   description: 'Melhor Buffet da região. Cowabunga', payment: 'PIX, Cartão de Débito', owner:)

    post(buffets_path, params: { buffet: { brand_name: 'Troca via request' } })

    expect(response).to redirect_to root_path
  end
end
