require 'rails_helper'

describe "Owner view events" do
  it 'from homepage' do
    owner = Owner.create!(name: 'Donatello Yoshi', email: 'donatello.yoshi@email.com', password: 'donatello123')

    buffet = Buffet.create!(brand_name: 'TMNT Buffet', payment: 'PIX', owner:)

    Event.create!(name: 'Festa infantil', description: 'Festa para crianças com temática TMNT', min_people: 10,
                  max_people: 100, duration: 300, menu: 'Pizza', alcoholic_beverages: false, decoration: true,
                  parking: true, parking_valet: false, customer_space: true, buffet:)

    login_as owner
    visit root_path
    click_on 'TMNT Buffet'
    click_on 'Festa infantil'

    expect(page).to have_content 'Festa infantil'
    expect(page).to have_content 'Festa para crianças com temática TMNT'
    expect(page).to have_content 'Mínimo de pessoas: 10'
    expect(page).to have_content 'Máximo de pessoas: 100'
    expect(page).to have_content 'Duração 300 min'
    expect(page).to have_content 'Cardápio: Pizza'
    expect(page).to have_content 'Decoração'
    expect(page).to have_content 'Serviço de estacionamento'
    expect(page).to have_content 'Evento em residência'
    expect(page).not_to have_content 'Bebidas alcoólicas'
    expect(page).not_to have_content 'Serviço de Valet'
  end

  it 'there is no event' do
    owner = Owner.create!(name: 'Donatello Yoshi', email: 'donatello.yoshi@email.com', password: 'donatello123')

    Buffet.create!(brand_name: 'TMNT Buffet', payment: 'PIX', owner:)

    login_as owner
    visit root_path
    click_on 'TMNT Buffet'

    expect(page).to have_content 'Nenhum evento cadastrado! Clique aqui para cadastrar.'
    expect(page).to have_link 'Clique aqui', href: new_event_path
  end
end
