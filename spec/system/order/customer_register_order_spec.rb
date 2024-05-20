require 'rails_helper'

describe 'Customer register order' do
  it 'must be logged in' do
    owner = Owner.create!(name: 'Splinter', email: 'splinter@email.com', password: 'password')

    buffet = Buffet.create!(brand_name: 'Teenage Mutant Ninja Turtles', corporate_name: 'TMNT Splinter LTDA',
                            registration_number: '88392017000182', phone: '11912341234',
                            email: 'contato@tmntsplinter.com', address: 'Rua Estados Unidos, 1030 - Jardins',
                            city: 'São Paulo', state: 'SP', zip_code: '01234123',
                            description: 'Melhor Buffet da região. Cowabunga', payment: 'PIX, Cartão de Débito', owner:)

    event = Event.create!(name: 'Festa de casamento', description: 'Festa de casamento dos sonhos', min_people: 10,
                          max_people: 100, duration: 420, menu: 'Pizza', alcoholic_beverages: true, decoration: true,
                          parking: true, parking_valet: true, customer_space: true, buffet:)

    EventCost.create!(description: 'Dias de semana', minimum: 2_000, additional_per_person: 70, overtime: 1000, event:)

    visit root_path
    click_on 'Teenage Mutant Ninja Turtles'
    click_on 'Festa de casamento'

    expect(page).not_to have_content 'Contratar serviço'
  end

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

    EventCost.create!(description: 'Dias de semana', minimum: 2_000, additional_per_person: 70, overtime: 1000, event:)

    customer = Customer.create!(name: 'Dragon Shiryu', cpf: '665.455.630-50', email: 'shiryu@email.com',
                                password: 'shiryu123')

    login_as customer, scope: :customer
    visit root_path
    click_on 'Teenage Mutant Ninja Turtles'
    click_on 'Festa de casamento'
    click_on 'Contratar serviço'

    expect(page).to have_content 'Contratar Festa de casamento'
    expect(page).to have_field 'Data do evento', type: 'date'
    expect(page).to have_field 'Quantidade de pessoas', type: 'number'
    expect(page).to have_field 'Detalhes do evento', type: 'textarea'
    expect(page).to have_field 'Local do evento', type: 'text'
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

    EventCost.create!(description: 'Dias de semana', minimum: 2_000, additional_per_person: 70, overtime: 1000, event:)

    customer = Customer.create!(name: 'Dragon Shiryu', cpf: '665.455.630-50', email: 'shiryu@email.com',
                                password: 'shiryu123')

    allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('ABCD1234')
    future_date = 2.week.from_now

    login_as customer, scope: :customer
    visit event_path(event)
    click_on 'Contratar serviço'
    fill_in 'Data do evento', with: future_date
    fill_in 'Quantidade de pessoas', with: 80
    fill_in 'Detalhes do evento', with: 'Festa muito especial'
    fill_in 'Local do evento', with: 'Sítio do Barnabé'
    click_on 'Criar Pedido'

    expect(page).to have_content 'Pedido realizado com sucesso. Aguardar aprovação do Buffet'
    expect(page).to have_content "#{future_date.strftime('%d/%m/%Y')} - ABCD1234"
    expect(page).to have_content 'Teenage Mutant Ninja Turtles'
    expect(page).to have_content 'Evento: Festa de casamento'
    expect(page).to have_content 'Status: Aguardando avaliação do buffet'
    expect(page).to have_content 'Detalhes da festa: Festa muito especial'
    expect(page).to have_content 'Local da festa: Sítio do Barnabé'
    expect(page).to have_content 'Número de pessoas: 80'
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

    EventCost.create!(description: 'Dias de semana', minimum: 2_000, additional_per_person: 70, overtime: 1000, event:)

    customer = Customer.create!(name: 'Dragon Shiryu', cpf: '665.455.630-50', email: 'shiryu@email.com',
                                password: 'shiryu123')

    login_as customer, scope: :customer
    visit event_path(event)
    click_on 'Contratar serviço'
    fill_in 'Data do evento', with: ''
    click_on 'Criar Pedido'

    expect(page).to have_content 'Atente-se aos erros abaixo:'
    expect(page).to have_content 'Data do evento não pode ficar em branco'
    expect(page).to have_content 'Data do evento deve ser futura'
    expect(page).to have_content 'Quantidade de pessoas não pode ficar em branco'
    expect(page).to have_content 'Quantidade de pessoas deve ser positivo'
    expect(page).to have_content 'Detalhes do evento não pode ficar em branco'
    expect(page).to have_content 'Local do evento não pode ficar em branco'
    expect(page).not_to have_content 'Buffet não pode ficar em branco'
    expect(page).not_to have_content 'Cliente não pode ficar em branco'
    expect(page).not_to have_content 'Evento não pode ficar em branco'
  end
end
