require 'rails_helper'

describe 'Owner view events' do
  it 'from homepage' do
    owner = Owner.create!(name: 'Donatello Yoshi', email: 'donatello.yoshi@email.com', password: 'donatello123')

    buffet = Buffet.create!(brand_name: 'Teenage Mutant Ninja Turtles', corporate_name: 'TMNT Splinter LTDA',
                            registration_number: '88392017000182', phone: '11912341234',
                            email: 'contato@tmntsplinter.com', address: 'Rua Estados Unidos, 1030 - Jardins',
                            city: 'São Paulo', state: 'SP', zip_code: '01234123',
                            description: 'Melhor Buffet da região. Cowabunga', payment: 'PIX, Cartão de Débito', owner:)

    Event.create!(name: 'Festa infantil', description: 'Festa para crianças com temática TMNT', min_people: 10,
                  max_people: 100, duration: 300, menu: 'Pizza', alcoholic_beverages: false, decoration: true,
                  parking: true, parking_valet: false, customer_space: true, buffet:)

    login_as owner
    visit root_path
    click_on 'Teenage Mutant Ninja Turtles'
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

    Buffet.create!(brand_name: 'Teenage Mutant Ninja Turtles', corporate_name: 'TMNT Splinter LTDA',
                   registration_number: '88392017000182', phone: '11912341234',
                   email: 'contato@tmntsplinter.com', address: 'Rua Estados Unidos, 1030 - Jardins',
                   city: 'São Paulo', state: 'SP', zip_code: '01234123',
                   description: 'Melhor Buffet da região. Cowabunga', payment: 'PIX, Cartão de Débito', owner:)

    login_as owner
    visit root_path
    click_on 'Teenage Mutant Ninja Turtles'

    expect(page).to have_content 'Nenhum evento cadastrado! Clique aqui para cadastrar.'
    expect(page).to have_link 'Clique aqui', href: new_event_path
  end
end
