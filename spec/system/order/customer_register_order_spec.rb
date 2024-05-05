require 'rails_helper'

describe 'Customer register order' do
  it 'must be logged in' do
    owner = Owner.create!(name: 'Splinter', email: 'splinter@email.com', password: 'password')

    buffet = Buffet.create!(brand_name: 'TMNT Buffet', payment: 'PIX', owner:)

    event = Event.create!(name: 'Festa de casamento', description: 'Festa de casamento dos sonhos', min_people: 10,
                          max_people: 100, duration: 420, menu: 'Pizza', alcoholic_beverages: true, decoration: true,
                          parking: true, parking_valet: true, customer_space: true, buffet:)

    EventCost.create!(description: 'Dias de semana', minimum: 2_000, additional_per_person: 70, overtime: 1000, event:)
    EventCost.create!(description: 'Fim de semana', minimum: 4_000, additional_per_person: 140, overtime: 2000, event:)

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
    EventCost.create!(description: 'Fim de semana', minimum: 4_000, additional_per_person: 140, overtime: 2000, event:)

    customer = Customer.create!(name: 'Dragon Shiryu', cpf: '665.455.630-50', email: 'shiryu@email.com',
                                password: 'shiryu123')

    login_as customer, scope: :customer
    visit root_path
    click_on 'TMNT Buffet'
    click_on 'Festa de casamento'
    click_on 'Contratar serviço'

    expect(page).to have_field 'Data do evento', type: 'datetime'
    expect(page).to have_field 'Número de pessoas', type: 'number'
    expect(page).to have_field 'Detalhes da festa', type: 'area'
    expect(page).to have_field 'Local da festa', type: 'text'
  end

  it 'successfully' do
    owner = Owner.create!(name: 'Splinter', email: 'splinter@email.com', password: 'password')

    buffet = Buffet.create!(brand_name: 'TMNT Buffet', payment: 'PIX', owner:)

    event = Event.create!(name: 'Festa de casamento', description: 'Festa de casamento dos sonhos', min_people: 10,
                          max_people: 100, duration: 420, menu: 'Pizza', alcoholic_beverages: true, decoration: true,
                          parking: true, parking_valet: true, customer_space: true, buffet:)

    EventCost.create!(description: 'Dias de semana', minimum: 2_000, additional_per_person: 70, overtime: 1000, event:)
    EventCost.create!(description: 'Fim de semana', minimum: 4_000, additional_per_person: 140, overtime: 2000, event:)

    customer = Customer.create!(name: 'Dragon Shiryu', cpf: '665.455.630-50', email: 'shiryu@email.com',
                                password: 'shiryu123')

    login_as customer, scope: :customer
    visit event_path(event)
    click_on 'Contratar serviço'
    fill_in 'Data do evento', with: 2.week.ago
    fill_in 'Número de pessoas', with: 80
    fill_in 'Detalhes da festa', with: 'Festa muito especial'
    fill_in 'Local da festa', with: 'Será no Sítio do Barnabé'
    click_on 'Criar Pedido'

    expect(page).to have_content 'TMNT Buffet'
    expect(page).to have_content 'Festa de casamento'
    expect(page).to have_content 'Data - Código'
  end
end
