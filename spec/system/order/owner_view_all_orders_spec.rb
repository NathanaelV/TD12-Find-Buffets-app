require 'rails_helper'

describe 'Owner view all orders' do
  it 'from homepage' do
    owner = Owner.create!(name: 'Splinter', email: 'splinter@email.com', password: 'password')
    phoenix = Owner.create!(name: 'Phoenix Ikki', email: 'phoenix.ikki@saint.com', password: 'phoenix.ikki123')

    buffet = Buffet.create!(brand_name: 'TMNT Buffet', payment: 'PIX', owner:)
    seiya_buffet = Buffet.create!(brand_name: 'Os Cavaleiro dos Zodíacos', payment: 'Debito', owner: phoenix)

    event = Event.create!(name: 'Festa de casamento', description: 'Festa de casamento dos sonhos', min_people: 10,
                          max_people: 100, duration: 420, menu: 'Pizza', alcoholic_beverages: true, decoration: true,
                          parking: true, parking_valet: true, customer_space: true, buffet:)

    second_event = Event.create!(name: 'Festa infantil', description: 'Festa para crianças com temática TMNT',
                                 min_people: 10, max_people: 100, duration: 300, menu: 'Pizza',
                                 alcoholic_beverages: false, decoration: true, parking: true, parking_valet: false,
                                 customer_space: true, buffet:)

    seiya_event = Event.create!(name: 'Festa de casamento', description: 'Casamento dos sonhos', min_people: 10,
                                max_people: 100, duration: 420, menu: 'Pizza', alcoholic_beverages: true,
                                decoration: true, parking: true, parking_valet: true, customer_space: true,
                                buffet: seiya_buffet)

    customer = Customer.create!(name: 'Dragon Shiryu', cpf: '665.455.630-50', email: 'shiryu@email.com',
                                password: 'shiryu123')

    second_customer = Customer.create!(name: 'Donatello Hamato', cpf: '599.622.000-83', email: 'donatello@email.com',
                                       password: 'donatello123')

    future_date = 2.week.from_now.strftime('%d/%m/%Y')
    order = Order.create!(event_date: future_date, people: 80, details: 'Dia especial', address: 'Sítio', buffet:,
                          customer:, event:)

    second_future_date = 3.week.from_now.strftime('%d/%m/%Y')
    second_order = Order.create!(event_date: second_future_date, people: 80, details: 'Dia especial', address: 'Sítio',
                                 buffet:, customer: second_customer, event: second_event)

    seiya_future_date = 3.week.from_now.strftime('%d/%m/%Y')
    seiya_order = Order.create!(event_date: second_future_date, people: 80, details: 'Dia especial', address: 'Buffet',
                                buffet: seiya_buffet, customer:, event: seiya_event)

    login_as owner, scope: :owner
    visit root_path
    within 'nav' do
      click_on 'Pedidos'
    end

    expect(page).to have_content 'Pedidos do TMNT Buffet'
    expect(page).to have_content "#{future_date} - #{order.code}"
    expect(page).to have_content "#{second_future_date} - #{second_order.code}"
    expect(page).not_to have_content "#{seiya_future_date} - #{seiya_order.code}"
  end

  it 'pending first' do
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

    second_future_date = 2.week.from_now.strftime('%d/%m/%Y')
    second_order = Order.create!(event_date: second_future_date, people: 80, details: 'Dia especial', address: 'Sítio',
                                 buffet:, customer:, event:)

    third_future_date = 3.week.from_now.strftime('%d/%m/%Y')
    third_order = Order.create!(event_date: third_future_date, people: 80, details: 'Dia especial', address: 'Buffet',
                                buffet:, customer:, event:, status: :approved)

    fourth_future_date = 3.week.from_now.strftime('%d/%m/%Y')
    fourth_order = Order.create!(event_date: third_future_date, people: 80, details: 'Dia especial', address: 'Buffet',
                                 buffet:, customer:, event:, status: :approved)

    fifth_future_date = 3.week.from_now.strftime('%d/%m/%Y')
    fifth_order = Order.create!(event_date: third_future_date, people: 80, details: 'Dia especial', address: 'Buffet',
                                buffet:, customer:, event:, status: :canceled)

    sixth_future_date = 3.week.from_now.strftime('%d/%m/%Y')
    sixth_order = Order.create!(event_date: third_future_date, people: 80, details: 'Dia especial', address: 'Buffet',
                                buffet:, customer:, event:, status: :canceled)

    login_as owner, scope: :owner
    visit root_path
    within 'nav' do
      click_on 'Pedidos'
    end

    text_orders = <<~ORDERS.strip
      Aguardando avaliação:
      #{future_date} - #{order.code}
      #{second_future_date} - #{second_order.code}
      Aprovados:
      #{third_future_date} - #{third_order.code}
      #{fourth_future_date} - #{fourth_order.code}
      Cancelados:
      #{fifth_future_date} - #{fifth_order.code}
      #{sixth_future_date} - #{sixth_order.code}
    ORDERS

    expect(page).to have_content 'Pedidos do TMNT Buffet'
    expect(page).to have_content text_orders
  end

  it 'if there is an order' do
    owner = Owner.create!(name: 'Splinter', email: 'splinter@email.com', password: 'password')

    Buffet.create!(brand_name: 'TMNT Buffet', payment: 'PIX', owner:)

    login_as owner, scope: :owner
    visit root_path
    within 'nav' do
      click_on 'Pedidos'
    end

    expect(page).to have_content 'Nenhum evento pendente.'
    expect(page).to have_content 'Nenhum evento aprovado.'
    expect(page).to have_content 'Nenhum evento cancelado.'
  end
end
