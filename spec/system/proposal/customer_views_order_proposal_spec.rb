require 'rails_helper'

describe 'Customer views order proposal' do
  it 'successfully' do
    owner = Owner.create!(name: 'Splinter', email: 'splinter@email.com', password: 'password')

    buffet = Buffet.create!(brand_name: 'TMNT Buffet', payment: 'PIX', owner:)

    event = Event.create!(name: 'Festa de casamento', description: 'Festa de casamento dos sonhos', min_people: 10,
                          max_people: 100, duration: 420, menu: 'Pizza', alcoholic_beverages: true, decoration: true,
                          parking: true, parking_valet: true, customer_space: true, buffet:)

    event_cost = EventCost.create!(description: 'Dias de semana', minimum: 200_000, additional_per_person: 7_000,
    overtime: 100_000, event:)

    customer = Customer.create!(name: 'Dragon Shiryu', cpf: '665.455.630-50', email: 'shiryu@email.com',
                                password: 'shiryu123')

    future_date = 2.week.from_now.strftime('%d/%m/%Y')
    order = Order.create!(event_date: future_date, people: 80, details: 'Dia especial', address: 'Sítio', buffet:,
                          customer:, event:)

    proposal_future_date = 1.week.from_now.strftime('%d/%m/%Y')

    Proposal.create!(order:, event:, event_cost:, customer:, cost: 690_000, validate_date: proposal_future_date,
                     price_change: -40_000, price_change_details: 'Gosto de múltiplos de 500',
                     payment: 'Cartão de Débito')

    login_as customer, scope: :customer
    visit root_path
    within 'nav' do
      click_on 'Meus Pedidos'
    end

    expect(page).to have_content 'Aguardando Confirmação:'
    expect(page).to have_content "#{future_date} - #{order.code}: Confirmar até #{proposal_future_date}"
  end

  xit 'if it is on deadline' do
    
  end

  it 'and view details' do
    owner = Owner.create!(name: 'Splinter', email: 'splinter@email.com', password: 'password')

    buffet = Buffet.create!(brand_name: 'TMNT Buffet', payment: 'PIX', owner:)

    event = Event.create!(name: 'Festa de casamento', description: 'Festa de casamento dos sonhos', min_people: 10,
                          max_people: 100, duration: 420, menu: 'Pizza', alcoholic_beverages: true, decoration: true,
                          parking: true, parking_valet: true, customer_space: true, buffet:)

    event_cost = EventCost.create!(description: 'Dias de semana', minimum: 200_000, additional_per_person: 7_000,
    overtime: 100_000, event:)

    customer = Customer.create!(name: 'Dragon Shiryu', cpf: '665.455.630-50', email: 'shiryu@email.com',
                                password: 'shiryu123')

    future_date = 2.week.from_now.strftime('%d/%m/%Y')
    order = Order.create!(event_date: future_date, people: 80, details: 'Dia especial', address: 'Sítio', buffet:,
                          customer:, event:)

    proposal_future_date = 1.week.from_now.strftime('%d/%m/%Y')

    Proposal.create!(order:, event:, event_cost:, customer:, cost: 690_000, validate_date: proposal_future_date,
                     price_change: -40_000, price_change_details: 'Gosto de múltiplos de 500',
                     payment: 'Cartão de Débito')

    login_as customer, scope: :customer
    visit root_path
    within 'nav' do
      click_on 'Meus Pedidos'
    end
    click_on 'Ver proposta'

    expect(page).to have_content "Proposta do pedido #{future_date} - #{order.code}"
    expect(page).to have_content "Confirmar até #{proposal_future_date}"
    expect(page).to have_content 'Custo do evento: 6900.00'
    expect(page).to have_content 'Taxa/Desconto: -400.00'
    expect(page).to have_content 'Justificativa: Gosto de múltiplos de 500'
    expect(page).to have_content 'Preço final: 6500.00'
    expect(page).to have_content 'Forma de pagamento: Cartão de Débito'
    expect(page).to have_button 'Confirmar proposta'
  end
end
