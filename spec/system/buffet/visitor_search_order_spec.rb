require 'rails_helper'

describe 'User search buffet' do
  it 'on homepage' do
    visit root_path

    within('header nav') do
      expect(page).to have_field 'Buscar Buffet'
      expect(page).to have_button 'Buscar'
    end
  end

  it 'find buffet by brand name' do
    owner = Owner.create!(name: 'Splinter', email: 'splinter@email.com', password: 'password')

    Buffet.create!(brand_name: 'TMNT Buffet', state: 'SP', city: 'São Paulo', payment: 'PIX', owner:)
    Buffet.create!(brand_name: 'TMNT Eventos', state: 'BA', city: 'Salvador', payment: 'PIX', owner:)
    Buffet.create!(brand_name: 'Saint Seiya Buffet', state: 'SP', city: 'São Paulo', payment: 'PIX', owner:)

    visit root_path
    fill_in 'Buscar Buffet', with: 'TMNT'
    click_on 'Buscar'

    expect(page).to have_content 'Resultado da busca por: TMNT'
    expect(page).to have_content '2 Buffets encontrados'
    expect(page).to have_content 'TMNT Buffet'
    expect(page).to have_content 'SP - São Paulo'
    expect(page).to have_content 'TMNT Eventos'
    expect(page).to have_content 'BA - Salvador'
    expect(page).not_to have_content 'Saint Seiya Buffet'
  end

  it 'find buffet by city on Buffef show' do
    owner = Owner.create!(name: 'Splinter', email: 'splinter@email.com', password: 'password')

    Buffet.create!(brand_name: 'TMNT Buffet', state: 'SP', city: 'São Paulo', payment: 'PIX', owner:)
    Buffet.create!(brand_name: 'TMNT Eventos', state: 'BA', city: 'Salvador', payment: 'PIX', owner:)
    Buffet.create!(brand_name: 'Saint Seiya Buffet', state: 'SP', city: 'São Paulo', payment: 'PIX', owner:)

    visit root_path
    click_on 'TMNT Eventos'
    fill_in 'Buscar Buffet', with: 'São Paulo'
    click_on 'Buscar'

    expect(page).to have_content 'Resultado da busca por: São Paulo'
    expect(page).to have_content '2 Buffets encontrados'
    expect(page).to have_content 'TMNT Buffet'
    expect(page).to have_content 'SP - São Paulo'
    expect(page).to have_content 'Saint Seiya Buffet'
    expect(page).not_to have_content 'TMNT Eventos'
    expect(page).not_to have_content 'BA - Salvador'
  end

  it 'find buffet by Events' do
    owner = Owner.create!(name: 'Splinter', email: 'splinter@email.com', password: 'password')

    buffet = Buffet.create!(brand_name: 'TMNT Buffet', state: 'SP', city: 'São Paulo', payment: 'PIX', owner:)
    eventos = Buffet.create!(brand_name: 'TMNT Eventos', state: 'BA', city: 'Salvador', payment: 'PIX', owner:)
    seiya = Buffet.create!(brand_name: 'Saint Seiya Buffet', state: 'SP', city: 'São Paulo', payment: 'PIX', owner:)

    Event.create!(name: 'Festa infantil', description: 'Festa para crianças com temática TMNT', min_people: 10,
                  max_people: 100, duration: 300, menu: 'Pizza', alcoholic_beverages: false, decoration: true,
                  parking: true, parking_valet: false, customer_space: true, buffet:)
    Event.create!(name: 'Infantil festejando', description: 'Festa para crianças com temática TMNT', min_people: 10,
                  max_people: 100, duration: 300, menu: 'Pizza', alcoholic_beverages: false, decoration: true,
                  parking: true, parking_valet: false, customer_space: true, buffet: seiya)
    Event.create!(name: 'Festa de criança', description: 'Festa para crianças com temática TMNT', min_people: 10,
                  max_people: 100, duration: 300, menu: 'Pizza', alcoholic_beverages: false, decoration: true,
                  parking: true, parking_valet: false, customer_space: true, buffet: eventos)


    visit root_path
    click_on 'TMNT Buffet'
    click_on 'Festa infantil'
    fill_in 'Buscar Buffet', with: 'inFANtil'
    click_on 'Buscar'

    expect(page).to have_content 'Resultado da busca por: inFANtil'
    expect(page).to have_content '2 Buffets encontrados'
    expect(page).to have_content 'TMNT Buffet'
    expect(page).to have_content 'SP - São Paulo'
    expect(page).to have_content 'Saint Seiya Buffet'
    expect(page).not_to have_content 'TMNT Eventos'
    expect(page).not_to have_content 'BA - Salvador'
  end

  it 'find one buffet' do
    owner = Owner.create!(name: 'Splinter', email: 'splinter@email.com', password: 'password')

    Buffet.create!(brand_name: 'TMNT Buffet', state: 'SP', city: 'São Paulo', payment: 'PIX', owner:)

    visit root_path
    fill_in 'Buscar Buffet', with: 'TMNT Bu'
    click_on 'Buscar'

    expect(page).to have_content 'Resultado da busca por: TMNT Bu'
    expect(page).to have_content '1 Buffet encontrado'
    expect(page).to have_content 'TMNT Buffet'
    expect(page).to have_content 'SP - São Paulo'
  end
end
