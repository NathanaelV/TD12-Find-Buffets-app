require 'rails_helper'

describe 'Update Buffet' do
  it 'that is not yours without a Buffet' do
    owner = Owner.create!(name: 'Splinter', email: 'splinter@email.com', password: 'password')
    phoenix = Owner.create!(name: 'Phoenix Ikki', email: 'phoenix.ikki@saint.com', password: 'phoenix.ikki123')

    buffet = Buffet.create!(brand_name: 'Teenage Mutant Ninja Turtles', corporate_name: 'TMNT Splinter LTDA',
                            registration_number: '88392017000182', phone: '11912341234',
                            email: 'contato@tmntsplinter.com', address: 'Rua Estados Unidos, 1030 - Jardins',
                            city: 'São Paulo', state: 'SP', zip_code: '01234123',
                            description: 'Melhor Buffet da região. Cowabunga', payment: 'PIX, Cartão de Débito', owner:)

    body = { buffet: { id: 3, brand_name: 'Teen Titans', corporate_name: 'Justice League Teens',
                       registration_number: '70849145000147', phone: '11900001111', email: 'contato@teentitans.com',
                       address: 'Torre T, s/n - Ilha', city: 'Florianópolis', state: 'SC', zip_code: '88000-123',
                       description: 'Batman é o melhor.', payment: 'PIX, Cartão de Débito, Cartão de Crédito' } }

    login_as phoenix, scope: :owner
    put(buffet_path(buffet), params: body)

    # Where to redirect the other owner?
    expect(response).to redirect_to new_buffet_path
    expect(Buffet.first).to eq buffet
  end

  it 'that is not yours with a Buffet' do
    owner = Owner.create!(name: 'Splinter', email: 'splinter@email.com', password: 'password')
    phoenix = Owner.create!(name: 'Phoenix Ikki', email: 'phoenix.ikki@saint.com', password: 'phoenix.ikki123')

    buffet = Buffet.create!(brand_name: 'Teenage Mutant Ninja Turtles', corporate_name: 'TMNT Splinter LTDA',
                            registration_number: '88392017000182', phone: '11912341234',
                            email: 'contato@tmntsplinter.com', address: 'Rua Estados Unidos, 1030 - Jardins',
                            city: 'São Paulo', state: 'SP', zip_code: '01234123',
                            description: 'Melhor Buffet da região. Cowabunga', payment: 'PIX, Cartão de Débito', owner:)

    saint_seiya = Buffet.create!(brand_name: 'Os Cavaleiro dos Zodíacos', corporate_name: 'Saint Seiya LTDA',
                                 registration_number: '12192017000312', phone: '11905051212',
                                 email: 'contato@saintseiya.com', address: 'Estrada das 12 casas, 12 - Grécia',
                                 city: 'São Paulo', state: 'SP', zip_code: '01212005',
                                 description: 'Venha elevar o seu cosmo conosco.',
                                 payment: 'PIX, Cartão de Débito, Cartão de Crédito', owner: phoenix)

    body = { buffet: { id: 3, brand_name: 'Teen Titans', corporate_name: 'Justice League Teens',
                       registration_number: '70849145000147', phone: '11900001111', email: 'contato@teentitans.com',
                       address: 'Torre T, s/n - Ilha', city: 'Florianópolis', state: 'SC', zip_code: '88000-123',
                       description: 'Batman é o melhor.', payment: 'PIX, Cartão de Débito, Cartão de Crédito' } }

    login_as phoenix, scope: :owner
    put(buffet_path(buffet), params: body)

    expect(response).to redirect_to buffet_path(saint_seiya)
    expect(Buffet.first).to eq buffet
    expect(Buffet.last).to eq saint_seiya
  end

  it 'customer cannot edit' do
    owner = Owner.create!(name: 'Splinter', email: 'splinter@email.com', password: 'password')

    buffet = Buffet.create!(brand_name: 'Teenage Mutant Ninja Turtles', corporate_name: 'TMNT Splinter LTDA',
                            registration_number: '88392017000182', phone: '11912341234',
                            email: 'contato@tmntsplinter.com', address: 'Rua Estados Unidos, 1030 - Jardins',
                            city: 'São Paulo', state: 'SP', zip_code: '01234123',
                            description: 'Melhor Buffet da região. Cowabunga', payment: 'PIX, Cartão de Débito', owner:)

    customer = Customer.create!(name: 'Donatello Hamato', cpf: '599.622.000-83', email: 'donatello@email.com',
                                password: 'donatello123')

    login_as customer, scope: :customer
    put(buffet_path(buffet), params: { buffet: { brand_name: 'Troca via request' } })

    expect(response).to redirect_to new_owner_session_path
    expect(Buffet.first.brand_name).to eq 'Teenage Mutant Ninja Turtles'
  end

  it 'and visitor cannot' do
    owner = Owner.create!(name: 'Splinter', email: 'splinter@email.com', password: 'password')

    buffet = Buffet.create!(brand_name: 'Teenage Mutant Ninja Turtles', corporate_name: 'TMNT Splinter LTDA',
                            registration_number: '88392017000182', phone: '11912341234',
                            email: 'contato@tmntsplinter.com', address: 'Rua Estados Unidos, 1030 - Jardins',
                            city: 'São Paulo', state: 'SP', zip_code: '01234123',
                            description: 'Melhor Buffet da região. Cowabunga', payment: 'PIX, Cartão de Débito', owner:)

    put(buffet_path(buffet), params: { buffet: { brand_name: 'Troca via request' } })

    expect(response).to redirect_to new_owner_session_path
    expect(Buffet.first.brand_name).to eq 'Teenage Mutant Ninja Turtles'
  end
end
