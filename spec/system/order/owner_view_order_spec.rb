require 'rails_helper'

describe 'Owner view order' do
  it 'if authenticated' do
    visit root_path

    expect(page).not_to have_content 'Pedidos'
  end

  it 'successfully' do
    owner = Owner.create!(name: 'Splinter', email: 'splinter@email.com', password: 'password')

    buffet = Buffet.create!(brand_name: 'TMNT Buffet', payment: 'PIX', owner:)

    event = Event.create!(name: 'Festa de casamento', description: 'Festa de casamento dos sonhos', min_people: 10,
                          max_people: 100, duration: 420, menu: 'Pizza', alcoholic_beverages: true, decoration: true,
                          parking: true, parking_valet: true, customer_space: true, buffet:)

    customer = Customer.create!(name: 'Dragon Shiryu', cpf: '665.455.630-50', email: 'shiryu@email.com',
                                password: 'shiryu123')

    future_date = 1.week.from_now.strftime('%d/%m/%Y')
    order = Order.create!(event_date: future_date, people: 80, details: 'Dia especial', address: 'Sítio', buffet:,
                          customer:, event:)

    login_as owner, scope: :owner
    visit root_path
    within 'nav' do
      click_on 'Pedidos'
    end
    click_on "#{future_date} - #{order.code}"

    expect(page).to have_content "#{future_date} - #{order.code}"
    expect(page).to have_content 'TMNT Buffet'
    expect(page).to have_content 'Evento: Festa de casamento'
    expect(page).to have_content 'Status: Aguardando avaliação do buffet'
    expect(page).to have_content 'Detalhes da festa: Dia especial'
    expect(page).to have_content 'Local da festa: Sítio'
    expect(page).to have_content 'Número de pessoas: 80'
  end

  it 'if it belongs to his buffet' do
    owner = Owner.create!(name: 'Splinter', email: 'splinter@email.com', password: 'password')
    phoenix = Owner.create!(name: 'Phoenix Ikki', email: 'phoenix.ikki@saint.com', password: 'phoenix.ikki123')

    buffet = Buffet.create!(brand_name: 'TMNT Buffet', payment: 'PIX', owner:)
    Buffet.create!(brand_name: 'Seiya', payment: 'PIX', owner: phoenix)

    event = Event.create!(name: 'Festa de casamento', description: 'Festa de casamento dos sonhos', min_people: 10,
                          max_people: 100, duration: 420, menu: 'Pizza', alcoholic_beverages: true, decoration: true,
                          parking: true, parking_valet: true, customer_space: true, buffet:)

    customer = Customer.create!(name: 'Dragon Shiryu', cpf: '665.455.630-50', email: 'shiryu@email.com',
                                password: 'shiryu123')

    future_date = 1.week.from_now.strftime('%d/%m/%Y')
    order = Order.create!(event_date: future_date, people: 80, details: 'Dia especial', address: 'Sítio', buffet:,
                          customer:, event:)

    login_as phoenix, scope: :owner
    visit root_path
    within 'nav' do
      click_on 'Pedidos'
    end

    expect(page).to have_content 'Nenhum evento pendente.'
    expect(page).to have_content 'Nenhum evento aprovado.'
    expect(page).to have_content 'Nenhum evento cancelado.'
    expect(page).not_to have_content "#{future_date} - #{order.code}"
  end
end
