require 'rails_helper'

describe 'Customer register order' do
  it 'must be logged in' do
    owner = Owner.create!(name: 'Splinter', email: 'splinter@email.com', password: 'password')

    buffet = Buffet.create!(brand_name: 'TMNT Buffet', payment: 'PIX', owner:)

    event = Event.create!(name: 'Festa de casamento', description: 'Festa de casamento dos sonhos', min_people: 10,
                          max_people: 100, duration: 420, menu: 'Pizza', alcoholic_beverages: true, decoration: true,
                          parking: true, parking_valet: true, customer_space: true, buffet:)

    EventCost.create!(description: 'Dias de semana', minimum: 2_000, additional_per_person: 70, overtime: 1000, event:)

    visit root_path
    click_on 'TMNT Buffet'
    click_on 'Festa de casamento'

    expect(page).not_to have_content 'Contratar serviço'
  end

  it 'from homepage' do
    owner = Owner.create!(name: 'Splinter', email: 'splinter@email.com', password: 'password')

    buffet = Buffet.create!(brand_name: 'TMNT Buffet', payment: 'PIX', owner:)

    event = Event.create!(name: 'Festa de casamento', description: 'Festa de casamento dos sonhos', min_people: 10,
                          max_people: 100, duration: 420, menu: 'Pizza', alcoholic_beverages: true, decoration: true,
                          parking: true, parking_valet: true, customer_space: true, buffet:)

    EventCost.create!(description: 'Dias de semana', minimum: 2_000, additional_per_person: 70, overtime: 1000, event:)

    customer = Customer.create!(name: 'Dragon Shiryu', cpf: '665.455.630-50', email: 'shiryu@email.com',
                                password: 'shiryu123')

    login_as customer, scope: :customer
    visit root_path
    click_on 'TMNT Buffet'
    click_on 'Festa de casamento'
    click_on 'Contratar serviço'

    expect(page).to have_content 'Contratar Festa de casamento'
    expect(page).to have_field 'Data do evento', type: 'date'
    expect(page).to have_field 'Número de pessoas', type: 'number'
    expect(page).to have_field 'Detalhes da festa', type: 'textarea'
    expect(page).to have_field 'Local da festa', type: 'text'
  end

  it 'successfully' do
    owner = Owner.create!(name: 'Splinter', email: 'splinter@email.com', password: 'password')

    buffet = Buffet.create!(brand_name: 'TMNT Buffet', payment: 'PIX', owner:)

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
    fill_in 'Número de pessoas', with: 80
    fill_in 'Detalhes da festa', with: 'Festa muito especial'
    fill_in 'Local da festa', with: 'Sítio do Barnabé'
    click_on 'Criar Pedido'

    expect(page).to have_content 'Pedido realizado com sucesso. Aguardar aprovação do Buffet'
    expect(page).to have_content "#{future_date.strftime('%d/%m/%Y')} - ABCD1234"
    expect(page).to have_content 'TMNT Buffet'
    expect(page).to have_content 'Evento: Festa de casamento'
    expect(page).to have_content 'Status: Aguardando avaliação do buffet'
    expect(page).to have_content 'Detalhes da festa: Festa muito especial'
    expect(page).to have_content 'Local da festa: Sítio do Barnabé'
    expect(page).to have_content 'Número de pessoas: 80'
  end

  it 'from homepage' do
    owner = Owner.create!(name: 'Splinter', email: 'splinter@email.com', password: 'password')

    buffet = Buffet.create!(brand_name: 'TMNT Buffet', payment: 'PIX', owner:)

    event = Event.create!(name: 'Festa de casamento', description: 'Festa de casamento dos sonhos', min_people: 10,
                          max_people: 100, duration: 420, menu: 'Pizza', alcoholic_beverages: true, decoration: true,
                          parking: true, parking_valet: true, customer_space: false, buffet:)

    EventCost.create!(description: 'Dias de semana', minimum: 2_000, additional_per_person: 70, overtime: 1000, event:)

    customer = Customer.create!(name: 'Dragon Shiryu', cpf: '665.455.630-50', email: 'shiryu@email.com',
                                password: 'shiryu123')

    login_as customer, scope: :customer
    visit root_path
    click_on 'TMNT Buffet'
    click_on 'Festa de casamento'
    click_on 'Contratar serviço'

    expect(page).to have_content 'Contratar Festa de casamento'
    expect(page).to have_field 'Data do evento', type: 'date'
    expect(page).to have_field 'Número de pessoas', type: 'number'
    expect(page).to have_field 'Detalhes da festa', type: 'textarea'
    expect(page).not_to have_field 'Local da festa'
  end
end
