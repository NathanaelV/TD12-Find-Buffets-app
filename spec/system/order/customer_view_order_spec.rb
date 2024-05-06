require 'rails_helper'

describe 'Customer view orders' do
  it 'must be logged' do
    visit root_path

    expect(page).not_to have_content 'Meus Pedidos'
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

    future_date = 2.week.from_now.strftime('%d/%m/%Y')
    order = Order.create!(event_date: future_date, people: 80, details: 'Dia especial', address: 'Sítio ', buffet:,
                          customer:, event:)

    second_future_date = 3.week.from_now.strftime('%d/%m/%Y')
    second_order = Order.create!(event_date: second_future_date, people: 80, details: 'Dia especial', address: 'Sítio ',
                                 buffet:, customer:, event:)

    login_as customer, scope: :customer
    visit root_path
    within 'nav' do
      click_on 'Meus Pedidos'
    end

    within 'h1#customer-orders' do
      expect(page).to have_content 'Meus Pedidos'
    end
    expect(page).to have_content "#{future_date} - #{order.code}"
    expect(page).to have_content "#{second_future_date} - #{second_order.code}"
  end

  it 'if there is one' do
    customer = Customer.create!(name: 'Dragon Shiryu', cpf: '665.455.630-50', email: 'shiryu@email.com',
                                password: 'shiryu123')

    login_as customer, scope: :customer
    visit root_path
    within 'nav' do
      click_on 'Meus Pedidos'
    end

    expect(page).to have_content 'Nenhum pedido cadastrado'
  end

  it 'order is approved' do
    owner = Owner.create!(name: 'Splinter', email: 'splinter@email.com', password: 'password')

    buffet = Buffet.create!(brand_name: 'TMNT Buffet', payment: 'PIX', owner:)

    event = Event.create!(name: 'Festa de casamento', description: 'Festa de casamento dos sonhos', min_people: 10,
                          max_people: 100, duration: 420, menu: 'Pizza', alcoholic_beverages: true, decoration: true,
                          parking: true, parking_valet: true, customer_space: true, buffet:)

    EventCost.create!(description: 'Dias de semana', minimum: 2_000, additional_per_person: 70, overtime: 1000, event:)

    customer = Customer.create!(name: 'Dragon Shiryu', cpf: '665.455.630-50', email: 'shiryu@email.com',
                                password: 'shiryu123')

    future_date = 2.week.from_now.strftime('%d/%m/%Y')
    order = Order.create!(event_date: future_date, people: 80, details: 'Dia especial', address: 'Sítio ', buffet:,
                          customer:, event:, status: :approved)

    login_as customer, scope: :customer
    visit root_path
    within 'nav' do
      click_on 'Meus Pedidos'
    end
    click_on "#{future_date} - #{order.code}"

    expect(page).to have_content 'Status: Pedido Confirmado'
  end

  it 'order is canceled' do
    owner = Owner.create!(name: 'Splinter', email: 'splinter@email.com', password: 'password')

    buffet = Buffet.create!(brand_name: 'TMNT Buffet', payment: 'PIX', owner:)

    event = Event.create!(name: 'Festa de casamento', description: 'Festa de casamento dos sonhos', min_people: 10,
                          max_people: 100, duration: 420, menu: 'Pizza', alcoholic_beverages: true, decoration: true,
                          parking: true, parking_valet: true, customer_space: true, buffet:)

    EventCost.create!(description: 'Dias de semana', minimum: 2_000, additional_per_person: 70, overtime: 1000, event:)

    customer = Customer.create!(name: 'Dragon Shiryu', cpf: '665.455.630-50', email: 'shiryu@email.com',
                                password: 'shiryu123')

    future_date = 2.week.from_now.strftime('%d/%m/%Y')
    order = Order.create!(event_date: future_date, people: 80, details: 'Dia especial', address: 'Sítio ', buffet:,
                          customer:, event:, status: :canceled)

    login_as customer, scope: :customer
    visit root_path
    within 'nav' do
      click_on 'Meus Pedidos'
    end
    click_on "#{future_date} - #{order.code}"

    expect(page).to have_content 'Status: Pedido Cancelado'
  end
end
