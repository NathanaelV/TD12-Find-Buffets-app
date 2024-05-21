require 'rails_helper'

describe 'Owner register proposal' do
  it 'from homepage' do
    owner = Owner.create!(name: 'Splinter', email: 'splinter@email.com', password: 'password')

    buffet = Buffet.create!(brand_name: 'Teenage Mutant Ninja Turtles', corporate_name: 'TMNT Splinter LTDA',
                            registration_number: '88392017000182', phone: '11912341234',
                            email: 'contato@tmntsplinter.com', address: 'Rua Estados Unidos, 1030 - Jardins',
                            city: 'São Paulo', state: 'SP', zip_code: '01234123',
                            description: 'Melhor Buffet da região. Cowabunga', payment: 'PIX, Cartão de Débito', owner:)

    event = Event.create!(name: 'Festa de casamento', description: 'Festa de casamento dos sonhos', min_people: 10,
                          max_people: 100, duration: 420, menu: 'Pizza', alcoholic_beverages: true, decoration: true,
                          parking: true, parking_valet: true, customer_space: true, buffet:)

    EventCost.create!(description: 'Dias de semana', minimum: 200_000, additional_per_person: 7_000, overtime: 100_000,
                      event:)

    customer = Customer.create!(name: 'Dragon Shiryu', cpf: '665.455.630-50', email: 'shiryu@email.com',
                                password: 'shiryu123')

    future_date = 2.week.from_now.strftime('%d/%m/%Y')
    order = Order.create!(event_date: future_date, people: 80, details: 'Dia especial', address: 'Sítio', buffet:,
                          customer:, event:)

    login_as owner, scope: :owner
    visit root_path
    within 'nav' do
      click_on 'Pedidos'
    end
    click_on "#{future_date} - #{order.code}"
    click_on 'Aprovar pedido'

    expect(page).to have_content 'Proposta para o cliente'
    expect(page).to have_field 'Valor final', with: 690_000
    expect(page).to have_field 'Data de expiração', type: 'date'
    expect(page).to have_field 'Taxa/Desconto'
    expect(page).to have_field 'Justificativa'
    expect(page).to have_field 'Forma de pagamento'
    expect(page).not_to have_content 'Atente-se aos erros abaixo:'
  end

  it 'successfully' do
    owner = Owner.create!(name: 'Splinter', email: 'splinter@email.com', password: 'password')

    buffet = Buffet.create!(brand_name: 'Teenage Mutant Ninja Turtles', corporate_name: 'TMNT Splinter LTDA',
                            registration_number: '88392017000182', phone: '11912341234',
                            email: 'contato@tmntsplinter.com', address: 'Rua Estados Unidos, 1030 - Jardins',
                            city: 'São Paulo', state: 'SP', zip_code: '01234123',
                            description: 'Melhor Buffet da região. Cowabunga', payment: 'PIX, Cartão de Débito', owner:)

    event = Event.create!(name: 'Festa de casamento', description: 'Festa de casamento dos sonhos', min_people: 10,
                          max_people: 100, duration: 420, menu: 'Pizza', alcoholic_beverages: true, decoration: true,
                          parking: true, parking_valet: true, customer_space: true, buffet:)

    EventCost.create!(description: 'Dias de semana', minimum: 200_000, additional_per_person: 7_000, overtime: 100_000,
                      event:)
    EventCost.create!(description: 'Fim de semana', minimum: 400_000, additional_per_person: 14_000, overtime: 200_000,
                      event:)

    customer = Customer.create!(name: 'Dragon Shiryu', cpf: '665.455.630-50', email: 'shiryu@email.com',
                                password: 'shiryu123')

    future_date = 2.week.from_now.strftime('%d/%m/%Y')
    order = Order.create!(event_date: future_date, people: 80, details: 'Dia especial', address: 'Sítio', buffet:,
                          customer:, event:)

    proposal_future_date = 1.week.from_now.to_date

    login_as owner, scope: :owner
    visit root_path
    within 'nav' do
      click_on 'Pedidos'
    end
    click_on "#{future_date} - #{order.code}"
    click_on 'Aprovar pedido'
    fill_in 'Data de expiração', with: proposal_future_date
    fill_in 'Taxa/Desconto', with: '-40000'
    fill_in 'Justificativa', with: 'Gosto de multiplos de 500'
    fill_in 'Forma de pagamento', with: 'Cartão de Débito'
    click_on 'Aprovar pedido'

    expect(current_path).to eq orders_path
    expect(page).to have_content "Proposta enviada com sucesso, para o pedido: #{future_date} - #{order.code}"
    expect(Order.find(order.id).status).to eq 'approved'
    expect(Proposal.first.cost).to eq 690_000
    expect(Proposal.first.validate_date).to eq proposal_future_date
    expect(Proposal.first.price_change).to eq(-40_000)
    expect(Proposal.first.price_change_details).to eq 'Gosto de multiplos de 500'
    expect(Proposal.first.payment).to eq 'Cartão de Débito'
    expect(Proposal.first.status).to eq 'sent'
  end

  it 'fields cannot be blank' do
    owner = Owner.create!(name: 'Splinter', email: 'splinter@email.com', password: 'password')

    buffet = Buffet.create!(brand_name: 'Teenage Mutant Ninja Turtles', corporate_name: 'TMNT Splinter LTDA',
                            registration_number: '88392017000182', phone: '11912341234',
                            email: 'contato@tmntsplinter.com', address: 'Rua Estados Unidos, 1030 - Jardins',
                            city: 'São Paulo', state: 'SP', zip_code: '01234123',
                            description: 'Melhor Buffet da região. Cowabunga', payment: 'PIX, Cartão de Débito', owner:)

    event = Event.create!(name: 'Festa de casamento', description: 'Festa de casamento dos sonhos', min_people: 10,
                          max_people: 100, duration: 420, menu: 'Pizza', alcoholic_beverages: true, decoration: true,
                          parking: true, parking_valet: true, customer_space: true, buffet:)

    EventCost.create!(description: 'Dias de semana', minimum: 200_000, additional_per_person: 7_000, overtime: 100_000,
                      event:)
    EventCost.create!(description: 'Fim de semana', minimum: 400_000, additional_per_person: 14_000, overtime: 200_000,
                      event:)

    customer = Customer.create!(name: 'Dragon Shiryu', cpf: '665.455.630-50', email: 'shiryu@email.com',
                                password: 'shiryu123')

    future_date = 2.week.from_now.strftime('%d/%m/%Y')
    order = Order.create!(event_date: future_date, people: 80, details: 'Dia especial', address: 'Sítio', buffet:,
                          customer:, event:)

    login_as owner, scope: :owner
    visit root_path
    within 'nav' do
      click_on 'Pedidos'
    end
    click_on "#{future_date} - #{order.code}"
    click_on 'Aprovar pedido'
    fill_in 'Valor final', with: ''
    click_on 'Aprovar pedido'

    expect(page).to have_content 'Atente-se aos erros abaixo:'
    expect(page).to have_content 'Valor final não pode ficar em branco'
    expect(page).to have_content 'Valor final deve ser positivo'
    expect(page).to have_content 'Data de expiração não pode ficar em branco'
    expect(page).to have_content 'Data de expiração deve ser futura'
    expect(page).to have_content 'Forma de pagamento não pode ficar em branco'
  end

  it 'if it is yours' do
    owner = Owner.create!(name: 'Splinter', email: 'splinter@email.com', password: 'password')
    phoenix = Owner.create!(name: 'Phoenix Ikki', email: 'phoenix.ikki@saint.com', password: 'phoenix.ikki123')

    buffet = Buffet.create!(brand_name: 'Teenage Mutant Ninja Turtles', corporate_name: 'TMNT Splinter LTDA',
                            registration_number: '88392017000182', phone: '11912341234',
                            email: 'contato@tmntsplinter.com', address: 'Rua Estados Unidos, 1030 - Jardins',
                            city: 'São Paulo', state: 'SP', zip_code: '01234123',
                            description: 'Melhor Buffet da região. Cowabunga', payment: 'PIX, Cartão de Débito', owner:)

    Buffet.create!(brand_name: 'Os Cavaleiro dos Zodíacos', corporate_name: 'Saint Seiya LTDA',
                   registration_number: '12192017000312', phone: '11905051212', email: 'contato@saintseiya.com',
                   address: 'Estrada das 12 casas, 12 - Grécia', city: 'São Paulo', state: 'SP', zip_code: '01212005',
                   description: 'Venha elevar o seu cosmo conosco.',
                   payment: 'PIX, Cartão de Débito, Cartão de Crédito', owner: phoenix)

    event = Event.create!(name: 'Festa de casamento', description: 'Festa de casamento dos sonhos', min_people: 10,
                          max_people: 100, duration: 420, menu: 'Pizza', alcoholic_beverages: true, decoration: true,
                          parking: true, parking_valet: true, customer_space: true, buffet:)

    EventCost.create!(description: 'Dias de semana', minimum: 200_000, additional_per_person: 7_000, overtime: 100_000,
                      event:)

    customer = Customer.create!(name: 'Dragon Shiryu', cpf: '665.455.630-50', email: 'shiryu@email.com',
                                password: 'shiryu123')

    future_date = 2.week.from_now.strftime('%d/%m/%Y')
    order = Order.create!(event_date: future_date, people: 80, details: 'Dia especial', address: 'Sítio', buffet:,
                          customer:, event:)

    login_as phoenix, scope: :owner
    visit new_order_proposal_path(order)

    expect(current_path).to eq root_path
  end

  it 'click on back button' do
    owner = Owner.create!(name: 'Splinter', email: 'splinter@email.com', password: 'password')

    buffet = Buffet.create!(brand_name: 'Teenage Mutant Ninja Turtles', corporate_name: 'TMNT Splinter LTDA',
                            registration_number: '88392017000182', phone: '11912341234',
                            email: 'contato@tmntsplinter.com', address: 'Rua Estados Unidos, 1030 - Jardins',
                            city: 'São Paulo', state: 'SP', zip_code: '01234123',
                            description: 'Melhor Buffet da região. Cowabunga', payment: 'PIX, Cartão de Débito', owner:)

    event = Event.create!(name: 'Festa de casamento', description: 'Festa de casamento dos sonhos', min_people: 10,
                          max_people: 100, duration: 420, menu: 'Pizza', alcoholic_beverages: true, decoration: true,
                          parking: true, parking_valet: true, customer_space: true, buffet:)

    EventCost.create!(description: 'Dias de semana', minimum: 200_000, additional_per_person: 7_000, overtime: 100_000,
                      event:)

    customer = Customer.create!(name: 'Dragon Shiryu', cpf: '665.455.630-50', email: 'shiryu@email.com',
                                password: 'shiryu123')

    future_date = 2.week.from_now.strftime('%d/%m/%Y')
    order = Order.create!(event_date: future_date, people: 80, details: 'Dia especial', address: 'Sítio', buffet:,
                          customer:, event:)

    login_as owner, scope: :owner
    visit root_path
    within 'nav' do
      click_on 'Pedidos'
    end
    click_on "#{future_date} - #{order.code}"
    click_on 'Aprovar pedido'
    click_on 'Voltar para Pedido'

    expect(current_path).to eq order_path(order)
  end
end
