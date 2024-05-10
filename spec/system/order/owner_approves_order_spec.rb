require 'rails_helper'

describe 'Owner approves order' do
  it 'if authorized' do
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

    login_as customer, scope: :customer
    visit root_path
    within 'nav' do
      click_on 'Pedidos'
    end
    click_on "#{future_date} - #{order.code}"

    expect(page).not_to have_content 'Aprovar pedido'
  end

  it 'from homepage' do
    owner = Owner.create!(name: 'Splinter', email: 'splinter@email.com', password: 'password')

    buffet = Buffet.create!(brand_name: 'TMNT Buffet', payment: 'PIX', owner:)

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
    expect(page).to have_field 'Data de expiração'
    expect(page).to have_field 'Taxa/Desconto'
    expect(page).to have_field 'Justificativa'
    expect(page).to have_field 'Forma de pagamento'
  end

  it 'successfully' do
    owner = Owner.create!(name: 'Splinter', email: 'splinter@email.com', password: 'password')

    buffet = Buffet.create!(brand_name: 'TMNT Buffet', payment: 'PIX', owner:)

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
end