require 'rails_helper'

describe 'Register order' do
  it 'and owner cannot' do
    owner = Owner.create!(name: 'Splinter', email: 'splinter@email.com', password: 'password')

    buffet = Buffet.create!(brand_name: 'Teenage Mutant Ninja Turtles', corporate_name: 'TMNT Splinter LTDA',
                            registration_number: '88392017000182', phone: '11912341234',
                            email: 'contato@tmntsplinter.com', address: 'Rua Estados Unidos, 1030 - Jardins',
                            city: 'São Paulo', state: 'SP', zip_code: '01234123',
                            description: 'Melhor Buffet da região. Cowabunga', payment: 'PIX, Cartão de Débito', owner:)

    event = Event.create!(name: 'Festa de casamento', description: 'Festa de casamento dos sonhos', min_people: 10,
                          max_people: 100, duration: 420, menu: 'Pizza', alcoholic_beverages: true, decoration: true,
                          parking: true, parking_valet: true, customer_space: true, buffet:)

    future_date = 1.week.from_now.strftime('%d/%m/%Y')
    body = { order: { event_date: future_date, people: 80, details: 'Dia especial', address: 'No Próprio Buffet' } }

    login_as owner, scope: :owner
    post(event_orders_path(event), params: body)

    expect(response).to redirect_to new_customer_session_path
    expect(Order.count).to eq 0
  end

  it 'and visitor cannot' do
    owner = Owner.create!(name: 'Splinter', email: 'splinter@email.com', password: 'password')

    buffet = Buffet.create!(brand_name: 'Teenage Mutant Ninja Turtles', corporate_name: 'TMNT Splinter LTDA',
                            registration_number: '88392017000182', phone: '11912341234',
                            email: 'contato@tmntsplinter.com', address: 'Rua Estados Unidos, 1030 - Jardins',
                            city: 'São Paulo', state: 'SP', zip_code: '01234123',
                            description: 'Melhor Buffet da região. Cowabunga', payment: 'PIX, Cartão de Débito', owner:)

    event = Event.create!(name: 'Festa de casamento', description: 'Festa de casamento dos sonhos', min_people: 10,
                          max_people: 100, duration: 420, menu: 'Pizza', alcoholic_beverages: true, decoration: true,
                          parking: true, parking_valet: true, customer_space: true, buffet:)

    future_date = 1.week.from_now.strftime('%d/%m/%Y')
    body = { order: { event_date: future_date, people: 80, details: 'Dia especial', address: 'No Próprio Buffet' } }

    login_as owner, scope: :owner
    post(event_orders_path(event), params: body)

    expect(response).to redirect_to new_customer_session_path
    expect(Order.count).to eq 0
  end
end
