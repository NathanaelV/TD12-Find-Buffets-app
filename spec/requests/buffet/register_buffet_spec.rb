require 'rails_helper'

describe 'Register Buffet' do
  it 'when owner already has a buffet' do
    owner = Owner.create!(name: 'Splinter', email: 'splinter@email.com', password: 'password')

    buffet = Buffet.create!(brand_name: 'Teenage Mutant Ninja Turtles', corporate_name: 'TMNT Splinter LTDA',
                            registration_number: '88392017000182', phone: '11912341234',
                            email: 'contato@tmntsplinter.com', address: 'Rua Estados Unidos, 1030 - Jardins',
                            city: 'São Paulo', state: 'SP', zip_code: '01234123',
                            description: 'Melhor Buffet da região. Cowabunga', payment: 'PIX, Cartão de Débito', owner:)

    body = { buffet: { id: 3, brand_name: 'Teen Titans', corporate_name: 'Justice League Teens',
                       registration_number: '70849145000147', phone: '11900001111', email: 'contato@teentitans.com',
                       address: 'Torre T, s/n - Ilha', city: 'Florianópolis', state: 'SC', zip_code: '88000-123',
                       description: 'Batman é o melhor.', payment: 'PIX, Cartão de Débito, Cartão de Crédito' } }

    login_as owner, scope: :owner
    post(buffets_path, params: body)

    expect(response).to redirect_to buffet_path(buffet)
  end

  it 'customer cannot' do
    owner = Owner.create!(name: 'Splinter', email: 'splinter@email.com', password: 'password')

    Buffet.create!(brand_name: 'Teenage Mutant Ninja Turtles', corporate_name: 'TMNT Splinter LTDA',
                   registration_number: '88392017000182', phone: '11912341234',
                   email: 'contato@tmntsplinter.com', address: 'Rua Estados Unidos, 1030 - Jardins',
                   city: 'São Paulo', state: 'SP', zip_code: '01234123',
                   description: 'Melhor Buffet da região. Cowabunga', payment: 'PIX, Cartão de Débito', owner:)

    customer = Customer.create!(name: 'Dragon Shiryu', cpf: '665.455.630-50', email: 'shiryu@email.com',
                                password: 'shiryu123')

    body = { buffet: { id: 3, brand_name: 'Teen Titans', corporate_name: 'Justice League Teens',
                       registration_number: '70849145000147', phone: '11900001111', email: 'contato@teentitans.com',
                       address: 'Torre T, s/n - Ilha', city: 'Florianópolis', state: 'SC', zip_code: '88000-123',
                       description: 'Batman é o melhor.', payment: 'PIX, Cartão de Débito, Cartão de Crédito' } }

    login_as customer, scope: :customer
    post(buffets_path, params: body)

    expect(response).to redirect_to new_owner_session_path
  end

  it 'visitor cannot register' do
    owner = Owner.create!(name: 'Splinter', email: 'splinter@email.com', password: 'password')

    Buffet.create!(brand_name: 'Teenage Mutant Ninja Turtles', corporate_name: 'TMNT Splinter LTDA',
                   registration_number: '88392017000182', phone: '11912341234',
                   email: 'contato@tmntsplinter.com', address: 'Rua Estados Unidos, 1030 - Jardins',
                   city: 'São Paulo', state: 'SP', zip_code: '01234123',
                   description: 'Melhor Buffet da região. Cowabunga', payment: 'PIX, Cartão de Débito', owner:)

    body = { buffet: { id: 3, brand_name: 'Teen Titans', corporate_name: 'Justice League Teens',
                       registration_number: '70849145000147', phone: '11900001111', email: 'contato@teentitans.com',
                       address: 'Torre T, s/n - Ilha', city: 'Florianópolis', state: 'SC', zip_code: '88000-123',
                       description: 'Batman é o melhor.', payment: 'PIX, Cartão de Débito, Cartão de Crédito' } }

    post(buffets_path, params: body)

    expect(response).to redirect_to new_owner_session_path
  end
end
