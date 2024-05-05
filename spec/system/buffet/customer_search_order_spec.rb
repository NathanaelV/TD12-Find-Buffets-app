require 'rails_helper'

describe 'Customer search buffet' do
  it 'on homepage' do
    customer = Customer.create!(name: 'Dragon Shiryu', cpf: '665.455.630-50', email: 'shiryu@email.com',
                                password: 'shiryu123')

    login_as customer, scope: :customer
    visit root_path

    within('header nav') do
      expect(page).to have_field 'Buscar Buffet'
      expect(page).to have_button 'Buscar'
    end
  end

  it 'find buffet by brand name' do
    owner = Owner.create!(name: 'Splinter', email: 'splinter@email.com', password: 'password')
    leo_yoshi = Owner.create!(name: 'Leonardo Yoshi', email: 'leonardo.yoshi@email.com', password: 'leonardo123')
    phoenix = Owner.create!(name: 'Phoenix Ikki', email: 'phoenix.ikki@saint.com', password: 'phoenix.ikki123')

    Buffet.create!(brand_name: 'TMNT Buffet', state: 'SP', city: 'São Paulo', payment: 'PIX', owner:)
    Buffet.create!(brand_name: 'TMNT Eventos', state: 'BA', city: 'Salvador', payment: 'PIX', owner: leo_yoshi)
    Buffet.create!(brand_name: 'Saint Seiya Buffet', state: 'SP', city: 'São Paulo', payment: 'PIX', owner: phoenix)

    customer = Customer.create!(name: 'Dragon Shiryu', cpf: '665.455.630-50', email: 'shiryu@email.com',
                                password: 'shiryu123')

    login_as customer, scope: :customer
    visit root_path
    fill_in 'Buscar Buffet', with: 'TMNT'
    click_on 'Buscar'

    expect(page).to have_content 'Resultado da busca por: TMNT'
    expect(page).to have_content '2 Buffets encontrados'
    expect(page).to have_content 'TMNT Buffet | SP - São Paulo TMNT Eventos | BA - Salvador'
    expect(page).not_to have_content 'Saint Seiya Buffet | SP - São Paulo'
  end

  it 'find buffet by city on Buffef show' do
    owner = Owner.create!(name: 'Splinter', email: 'splinter@email.com', password: 'password')
    leo_yoshi = Owner.create!(name: 'Leonardo Yoshi', email: 'leonardo.yoshi@email.com', password: 'leonardo123')
    phoenix = Owner.create!(name: 'Phoenix Ikki', email: 'phoenix.ikki@saint.com', password: 'phoenix.ikki123')

    Buffet.create!(brand_name: 'TMNT Buffet', state: 'SP', city: 'São Paulo', payment: 'PIX', owner:)
    Buffet.create!(brand_name: 'TMNT Eventos', state: 'BA', city: 'Salvador', payment: 'PIX', owner: leo_yoshi)
    Buffet.create!(brand_name: 'Saint Seiya Buffet', state: 'SP', city: 'São Paulo', payment: 'PIX', owner: phoenix)

    customer = Customer.create!(name: 'Dragon Shiryu', cpf: '665.455.630-50', email: 'shiryu@email.com',
                                password: 'shiryu123')

    login_as customer, scope: :customer
    visit root_path
    click_on 'TMNT Eventos'
    fill_in 'Buscar Buffet', with: 'São Paulo'
    click_on 'Buscar'

    expect(page).to have_content 'Resultado da busca por: São Paulo'
    expect(page).to have_content '2 Buffets encontrados'
    expect(page).to have_content 'Saint Seiya Buffet | SP - São Paulo TMNT Buffet | SP - São Paulo'
    expect(page).not_to have_content 'TMNT Eventos | BA - Salvador'
  end

  it 'find buffet by Events' do
    owner = Owner.create!(name: 'Splinter', email: 'splinter@email.com', password: 'password')
    leo_yoshi = Owner.create!(name: 'Leonardo Yoshi', email: 'leonardo.yoshi@email.com', password: 'leonardo123')
    phoenix = Owner.create!(name: 'Phoenix Ikki', email: 'phoenix.ikki@saint.com', password: 'phoenix.ikki123')

    buffet = Buffet.create!(brand_name: 'TMNT Buffet', state: 'SP', city: 'São Paulo', payment: 'PIX', owner:)
    eventos = Buffet.create!(brand_name: 'TMNT Eventos', state: 'BA', city: 'Salvador', payment: 'PIX',
                             owner: leo_yoshi)
    seiya = Buffet.create!(brand_name: 'Saint Seiya Buffet', state: 'SP', city: 'São Paulo', payment: 'PIX',
                           owner: phoenix)

    customer = Customer.create!(name: 'Dragon Shiryu', cpf: '665.455.630-50', email: 'shiryu@email.com',
                                password: 'shiryu123')

    Event.create!(name: 'Festa infantil', description: 'Festa para crianças com temática TMNT', min_people: 10,
                  max_people: 100, duration: 300, menu: 'Pizza', alcoholic_beverages: false, decoration: true,
                  parking: true, parking_valet: false, customer_space: true, buffet:)
    Event.create!(name: 'Infantil festejando', description: 'Festa para crianças com temática TMNT', min_people: 10,
                  max_people: 100, duration: 300, menu: 'Pizza', alcoholic_beverages: false, decoration: true,
                  parking: true, parking_valet: false, customer_space: true, buffet: seiya)
    Event.create!(name: 'Festa de criança', description: 'Festa para crianças com temática TMNT', min_people: 10,
                  max_people: 100, duration: 300, menu: 'Pizza', alcoholic_beverages: false, decoration: true,
                  parking: true, parking_valet: false, customer_space: true, buffet: eventos)

    login_as customer, scope: :customer
    visit root_path
    click_on 'TMNT Buffet'
    click_on 'Festa infantil'
    fill_in 'Buscar Buffet', with: 'inFANtil'
    click_on 'Buscar'

    expect(page).to have_content 'Resultado da busca por: inFANtil'
    expect(page).to have_content '2 Buffets encontrados'
    expect(page).to have_content 'Saint Seiya Buffet | SP - São Paulo TMNT Buffet | SP - São Paulo'
    expect(page).not_to have_content 'TMNT Eventos | BA - Salvador'
  end

  it 'find one buffet' do
    owner = Owner.create!(name: 'Splinter', email: 'splinter@email.com', password: 'password')

    Buffet.create!(brand_name: 'TMNT Buffet', state: 'SP', city: 'São Paulo', payment: 'PIX', owner:)

    customer = Customer.create!(name: 'Dragon Shiryu', cpf: '665.455.630-50', email: 'shiryu@email.com',
                                password: 'shiryu123')

    login_as customer, scope: :customer
    visit root_path
    fill_in 'Buscar Buffet', with: 'TMNT Bu'
    click_on 'Buscar'

    expect(page).to have_content 'Resultado da busca por: TMNT Bu'
    expect(page).to have_content '1 Buffet encontrado'
    expect(page).to have_content 'TMNT Buffet | SP - São Paulo'
  end

  it 'if query is empty' do
    owner = Owner.create!(name: 'Splinter', email: 'splinter@email.com', password: 'password')

    buffet = Buffet.create!(brand_name: 'TMNT Buffet', state: 'SP', city: 'São Paulo', payment: 'PIX', owner:)
    eventos = Buffet.create!(brand_name: 'TMNT Eventos', state: 'BA', city: 'Salvador', payment: 'PIX', owner:)
    seiya = Buffet.create!(brand_name: 'Saint Seiya Buffet', state: 'SP', city: 'São Paulo', payment: 'PIX', owner:)

    customer = Customer.create!(name: 'Dragon Shiryu', cpf: '665.455.630-50', email: 'shiryu@email.com',
                                password: 'shiryu123')

    Event.create!(name: 'Festa infantil', description: 'Festa para crianças com temática TMNT', min_people: 10,
                  max_people: 100, duration: 300, menu: 'Pizza', alcoholic_beverages: false, decoration: true,
                  parking: true, parking_valet: false, customer_space: true, buffet:)
    Event.create!(name: 'Infantil festejando', description: 'Festa para crianças com temática TMNT', min_people: 10,
                  max_people: 100, duration: 300, menu: 'Pizza', alcoholic_beverages: false, decoration: true,
                  parking: true, parking_valet: false, customer_space: true, buffet: seiya)
    Event.create!(name: 'Festa de criança', description: 'Festa para crianças com temática TMNT', min_people: 10,
                  max_people: 100, duration: 300, menu: 'Pizza', alcoholic_beverages: false, decoration: true,
                  parking: true, parking_valet: false, customer_space: true, buffet: eventos)

    login_as customer, scope: :customer
    visit root_path
    fill_in 'Buscar Buffet', with: ''
    click_on 'Buscar'

    expect(page).to have_content 'Resultado da busca por:'
    expect(page).to have_content '0 Buffets encontrados'
  end

  it 'cannot repeat buffet' do
    owner = Owner.create!(name: 'Splinter', email: 'splinter@email.com', password: 'password')
    leo_yoshi = Owner.create!(name: 'Leonardo Yoshi', email: 'leonardo.yoshi@email.com', password: 'leonardo123')
    phoenix = Owner.create!(name: 'Phoenix Ikki', email: 'phoenix.ikki@saint.com', password: 'phoenix.ikki123')

    buffet = Buffet.create!(brand_name: 'TMNT Buffet', state: 'SP', city: 'São Paulo', payment: 'PIX', owner:)
    eventos = Buffet.create!(brand_name: 'TMNT Eventos', state: 'BA', city: 'Salvador', payment: 'PIX',
                             owner: leo_yoshi)
    seiya = Buffet.create!(brand_name: 'Saint Seiya Buffet', state: 'SP', city: 'São Paulo', payment: 'PIX',
                           owner: phoenix)

    customer = Customer.create!(name: 'Dragon Shiryu', cpf: '665.455.630-50', email: 'shiryu@email.com',
                                password: 'shiryu123')

    Event.create!(name: 'Festa infantil', description: 'Festa para crianças com temática TMNT', min_people: 10,
                  max_people: 100, duration: 300, menu: 'Pizza', alcoholic_beverages: false, decoration: true,
                  parking: true, parking_valet: false, customer_space: true, buffet:)
    Event.create!(name: 'Infantil festejando', description: 'Festa para crianças com temática TMNT', min_people: 10,
                  max_people: 100, duration: 300, menu: 'Pizza', alcoholic_beverages: false, decoration: true,
                  parking: true, parking_valet: false, customer_space: true, buffet: seiya)
    Event.create!(name: 'Festa de criança', description: 'Festa para crianças com temática TMNT', min_people: 10,
                  max_people: 100, duration: 300, menu: 'Pizza', alcoholic_beverages: false, decoration: true,
                  parking: true, parking_valet: false, customer_space: true, buffet: eventos)

    login_as customer, scope: :customer
    visit root_path
    fill_in 'Buscar Buffet', with: 't'
    click_on 'Buscar'

    expect(page).to have_content 'Resultado da busca por:'
    expect(page).to have_content '3 Buffets encontrados'
    names_sorted = 'Saint Seiya Buffet | SP - São Paulo TMNT Buffet | SP - São Paulo TMNT Eventos | BA - Salvador'
    expect(page).to have_content names_sorted
  end
end
