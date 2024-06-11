require 'rails_helper'

describe 'Register Event' do
  it 'visitor cannot' do
    owner = Owner.create!(name: 'Splinter', email: 'splinter@email.com', password: 'password')

    Buffet.create!(brand_name: 'Teenage Mutant Ninja Turtles', corporate_name: 'TMNT Splinter LTDA',
                   registration_number: '88392017000182', phone: '11912341234',
                   email: 'contato@tmntsplinter.com', address: 'Rua Estados Unidos, 1030 - Jardins',
                   city: 'São Paulo', state: 'SP', zip_code: '01234123',
                   description: 'Melhor Buffet da região. Cowabunga', payment: 'PIX, Cartão de Débito', owner:)

    body = { event: { id: 3, name: 'Coffee Break', description: 'Coffee Break para crianças grandes', min_people: 20,
                      max_people: 120, duration: 240, menu: 'Pizza e café', alcoholic_beverages: true, decoration: true,
                      parking: true, parking_valet: true, customer_space: true } }

    post(events_path, params: body)

    expect(response).to redirect_to new_owner_session_path
  end

  it 'customer cannot' do
    owner = Owner.create!(name: 'Splinter', email: 'splinter@email.com', password: 'password')

    Buffet.create!(brand_name: 'Teenage Mutant Ninja Turtles', corporate_name: 'TMNT Splinter LTDA',
                   registration_number: '88392017000182', phone: '11912341234',
                   email: 'contato@tmntsplinter.com', address: 'Rua Estados Unidos, 1030 - Jardins',
                   city: 'São Paulo', state: 'SP', zip_code: '01234123',
                   description: 'Melhor Buffet da região. Cowabunga', payment: 'PIX, Cartão de Débito', owner:)

    customer = Customer.create!(name: 'Donatello Hamato', cpf: '599.622.000-83', email: 'donatello@email.com',
                                password: 'donatello123')

    body = { event: { name: 'Coffee Break', description: 'Coffee Break para crianças grandes', min_people: 20,
                      max_people: 120, duration: 240, menu: 'Pizza e café', alcoholic_beverages: true, decoration: true,
                      parking: true, parking_valet: true, customer_space: true } }

    login_as customer, scope: :customer
    post(events_path, params: body)

    expect(response).to redirect_to new_owner_session_path
  end
end
