require 'rails_helper'

describe 'Owner edit events' do
  it 'if authenticated' do
    owner = Owner.create!(name: 'Splinter', email: 'splinter@email.com', password: 'password')

    buffet = Buffet.create!(brand_name: 'TMNT Buffet', payment: 'PIX', owner:)

    Event.create!(name: 'Festa infantil', description: 'Festa para crianças com temática TMNT', min_people: 10,
                  max_people: 100, duration: 300, menu: 'Pizza', alcoholic_beverages: false, decoration: true,
                  parking: true, parking_valet: false, customer_space: true, buffet:)

    visit root_path
    click_on 'TMNT Buffet'
    click_on 'Festa infantil'

    expect(page).not_to have_content 'Editar Evento'
  end

  it 'from homepage' do
    owner = Owner.create!(name: 'Splinter', email: 'splinter@email.com', password: 'password')

    buffet = Buffet.create!(brand_name: 'TMNT Buffet', payment: 'PIX', owner:)

    Event.create!(name: 'Festa infantil', description: 'Festa para crianças com temática TMNT', min_people: 10,
                  max_people: 100, duration: 300, menu: 'Pizza', alcoholic_beverages: false, decoration: true,
                  parking: true, parking_valet: false, customer_space: true, buffet:)

    login_as owner
    visit root_path
    click_on 'TMNT Buffet'
    click_on 'Festa infantil'
    click_on 'Editar Evento'

    expect(page).to have_content 'Editar Festa infantil'
    expect(page).to have_field 'Nome',	with: 'Festa infantil'
    expect(page).to have_field 'Descrição',	with: 'Festa para crianças com temática TMNT'
    expect(page).to have_field 'Mínimo de pessoas',	with: '10'
    expect(page).to have_field 'Máximo de pessoas', with: '100'
    expect(page).to have_field 'Duração',	with: '300'
    expect(page).to have_field 'Cardápio', with: 'Pizza'
    expect(page).to have_checked_field 'Decoração'
    expect(page).to have_checked_field 'Serviço de estacionamento'
    expect(page).to have_checked_field 'Evento em residência'
    expect(page).to have_unchecked_field 'Bebidas alcoólicas'
    expect(page).to have_unchecked_field 'Serviço de Valet'
  end

  it 'successfully' do
    owner = Owner.create!(name: 'Splinter', email: 'splinter@email.com', password: 'password')

    buffet = Buffet.create!(brand_name: 'TMNT Buffet', payment: 'PIX', owner:)

    Event.create!(name: 'Festa de casamento', description: 'Festa de casamento dos sonhos', min_people: 10,
                  max_people: 100, duration: 420, menu: 'Pizza', alcoholic_beverages: true, decoration: true,
                  parking: true, parking_valet: true, customer_space: true, buffet:)

    login_as(owner)
    visit root_path
    click_on 'TMNT Buffet'
    click_on 'Festa de casamento'
    click_on 'Editar Evento'
    fill_in 'Nome',	with: 'Festa infantil'
    fill_in 'Descrição',	with: 'Festa para crianças com temática TMNT'
    fill_in 'Mínimo de pessoas',	with: '10'
    fill_in 'Máximo de pessoas', with: '100'
    fill_in 'Duração',	with: '300'
    fill_in 'Cardápio', with: 'Pizza'
    uncheck 'Bebidas alcoólicas'
    uncheck 'Serviço de Valet'
    click_on 'Atualizar Evento'

    expect(page).to have_content 'Evento atualizado com sucesso!'
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
end
