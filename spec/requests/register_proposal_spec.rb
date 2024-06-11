require 'rails_helper'

describe 'Register Proposal' do
  it 'owner if it yours' do
    owner = Owner.create!(name: 'Splinter', email: 'splinter@email.com', password: 'password')
    phoenix = Owner.create!(name: 'Phoenix Ikki', email: 'phoenix.ikki@saint.com', password: 'phoenix.ikki123')

    buffet = Buffet.create!(brand_name: 'Teenage Mutant Ninja Turtles', corporate_name: 'TMNT Splinter LTDA',
                            registration_number: '88392017000182', phone: '11912341234',
                            email: 'contato@tmntsplinter.com', address: 'Rua Estados Unidos, 1030 - Jardins',
                            city: 'São Paulo', state: 'SP', zip_code: '01234123',
                            description: 'Melhor Buffet da região. Cowabunga', payment: 'PIX, Cartão de Débito', owner:)

    event = Event.create!(name: 'Festa de casamento', description: 'Festa de casamento dos sonhos', min_people: 10,
                          max_people: 100, duration: 420, menu: 'Pizza', alcoholic_beverages: true, decoration: true,
                          parking: true, parking_valet: true, customer_space: true, buffet:)

    saint_seiya = Buffet.create!(brand_name: 'Os Cavaleiro dos Zodíacos', corporate_name: 'Saint Seiya LTDA',
                                 registration_number: '12192017000312', phone: '11905051212',
                                 email: 'contato@saintseiya.com', address: 'Estrada das 12 casas, 12 - Grécia',
                                 city: 'São Paulo', state: 'SP', zip_code: '01212005',
                                 description: 'Venha elevar o seu cosmo conosco.',
                                 payment: 'PIX, Cartão de Débito, Cartão de Crédito', owner: phoenix)

    customer = Customer.create!(name: 'Donatello Hamato', cpf: '599.622.000-83', email: 'donatello@email.com',
                                password: 'donatello123')

    order = Order.create!(event_date: 2.month.from_now.strftime('%d/%m/%Y'), people: 80, details: 'Dia especial',
                          address: 'Sítio do Barnabé', buffet:, customer:, event:)

    future_date = 1.week.from_now.strftime('%d/%m/%Y')
    body = { proposal: { cost: 690_000, validate_date: future_date, price_change: -40_000,
                         price_change_details: 'Gosto de múltiplos de 500', payment: 'Cartão de Débito' } }

    login_as phoenix, scope: :owner
    post(order_proposals_path(order), params: body)

    expect(response).to redirect_to buffet_path(saint_seiya)
    expect(Proposal.count).to eq 0
  end

  it 'visitor cannot' do
    owner = Owner.create!(name: 'Splinter', email: 'splinter@email.com', password: 'password')

    buffet = Buffet.create!(brand_name: 'Teenage Mutant Ninja Turtles', corporate_name: 'TMNT Splinter LTDA',
                            registration_number: '88392017000182', phone: '11912341234',
                            email: 'contato@tmntsplinter.com', address: 'Rua Estados Unidos, 1030 - Jardins',
                            city: 'São Paulo', state: 'SP', zip_code: '01234123',
                            description: 'Melhor Buffet da região. Cowabunga', payment: 'PIX, Cartão de Débito', owner:)

    event = Event.create!(name: 'Festa de casamento', description: 'Festa de casamento dos sonhos', min_people: 10,
                          max_people: 100, duration: 420, menu: 'Pizza', alcoholic_beverages: true, decoration: true,
                          parking: true, parking_valet: true, customer_space: true, buffet:)

    customer = Customer.create!(name: 'Donatello Hamato', cpf: '599.622.000-83', email: 'donatello@email.com',
                                password: 'donatello123')

    order = Order.create!(event_date: 2.month.from_now.strftime('%d/%m/%Y'), people: 80, details: 'Dia especial',
                          address: 'Sítio do Barnabé', buffet:, customer:, event:)

    future_date = 1.week.from_now.strftime('%d/%m/%Y')
    body = { proposal: { cost: 690_000, validate_date: future_date, price_change: -40_000,
                         price_change_details: 'Gosto de múltiplos de 500', payment: 'Cartão de Débito' } }

    post(order_proposals_path(order), params: body)

    expect(response).to redirect_to new_owner_session_path
    expect(Proposal.count).to eq 0
  end

  it 'customer cannot' do
    owner = Owner.create!(name: 'Splinter', email: 'splinter@email.com', password: 'password')

    buffet = Buffet.create!(brand_name: 'Teenage Mutant Ninja Turtles', corporate_name: 'TMNT Splinter LTDA',
                            registration_number: '88392017000182', phone: '11912341234',
                            email: 'contato@tmntsplinter.com', address: 'Rua Estados Unidos, 1030 - Jardins',
                            city: 'São Paulo', state: 'SP', zip_code: '01234123',
                            description: 'Melhor Buffet da região. Cowabunga', payment: 'PIX, Cartão de Débito', owner:)

    event = Event.create!(name: 'Festa de casamento', description: 'Festa de casamento dos sonhos', min_people: 10,
                          max_people: 100, duration: 420, menu: 'Pizza', alcoholic_beverages: true, decoration: true,
                          parking: true, parking_valet: true, customer_space: true, buffet:)

    customer = Customer.create!(name: 'Donatello Hamato', cpf: '599.622.000-83', email: 'donatello@email.com',
                                password: 'donatello123')

    order = Order.create!(event_date: 2.month.from_now.strftime('%d/%m/%Y'), people: 80, details: 'Dia especial',
                          address: 'Sítio do Barnabé', buffet:, customer:, event:)

    future_date = 1.week.from_now.strftime('%d/%m/%Y')
    body = { proposal: { cost: 690_000, validate_date: future_date, price_change: -40_000,
                         price_change_details: 'Gosto de múltiplos de 500', payment: 'Cartão de Débito' } }

    login_as customer, scope: :customer
    post(order_proposals_path(order), params: body)

    expect(response).to redirect_to new_owner_session_path
    expect(Proposal.count).to eq 0
  end
end
