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
    batman = Owner.create!(name: 'Bruce Wayne', email: 'bruce.wayne@dccomix.com', password: 'nanananana_batman!')
    phoenix = Owner.create!(name: 'Phoenix Ikki', email: 'phoenix.ikki@saint.com', password: 'phoenix.ikki123')

    Buffet.create!(brand_name: 'Teenage Mutant Ninja Turtles', corporate_name: 'TMNT Splinter LTDA',
                   registration_number: '88392017000182', phone: '11912341234', email: 'contato@tmntsplinter.com',
                   address: 'Rua Estados Unidos, 1030 - Jardins', city: 'São Paulo', state: 'SP', zip_code: '01234123',
                   description: 'Melhor Buffet da região. Cowabunga', payment: 'PIX, Cartão de Débito', owner:)

    Buffet.create!(brand_name: 'Teen Titans', corporate_name: 'Justice League Teens',
                   registration_number: '70849145000147', phone: '11900001111', email: 'contato@teentitans.com',
                   address: 'Torre T, s/n - Ilha', city: 'Florianópolis', state: 'SC', zip_code: '88000-123',
                   description: 'Batman é o melhor.', payment: 'PIX, Cartão de Débito, Cartão de Crédito',
                   owner: batman)

    Buffet.create!(brand_name: 'Os Cavaleiro dos Zodíacos', corporate_name: 'Saint Seiya LTDA',
                   registration_number: '12192017000312', phone: '11905051212', email: 'contato@saintseiya.com',
                   address: 'Estrada das 12 casas, 12 - Grécia', city: 'São Paulo', state: 'SP', zip_code: '01212005',
                   description: 'Venha elevar o seu cosmo conosco.', payment: 'Cartão de Débito, Cartão de Crédito',
                   owner: phoenix)

    visit root_path
    fill_in 'Buscar Buffet', with: 'Teen'
    click_on 'Buscar'

    expect(page).to have_content 'Resultado da busca por: Teen'
    expect(page).to have_content '2 Buffets encontrados'
    expect(page).to have_content 'Teen Titans | SC - Florianópolis Teenage Mutant Ninja Turtles | SP - São Paulo'
    expect(page).not_to have_content 'Os Cavaleiro dos Zodíacos | SP - São Paulo'
  end

  it 'find buffet by city on Buffef show' do
    owner = Owner.create!(name: 'Splinter', email: 'splinter@email.com', password: 'password')
    batman = Owner.create!(name: 'Bruce Wayne', email: 'bruce.wayne@dccomix.com', password: 'nanananana_batman!')
    phoenix = Owner.create!(name: 'Phoenix Ikki', email: 'phoenix.ikki@saint.com', password: 'phoenix.ikki123')

    Buffet.create!(brand_name: 'Teenage Mutant Ninja Turtles', corporate_name: 'TMNT Splinter LTDA',
                   registration_number: '88392017000182', phone: '11912341234', email: 'contato@tmntsplinter.com',
                   address: 'Rua Estados Unidos, 1030 - Jardins', city: 'São Paulo', state: 'SP', zip_code: '01234123',
                   description: 'Melhor Buffet da região. Cowabunga', payment: 'PIX, Cartão de Débito', owner:)

    Buffet.create!(brand_name: 'Teen Titans', corporate_name: 'Justice League Teens',
                   registration_number: '70849145000147', phone: '11900001111', email: 'contato@teentitans.com',
                   address: 'Torre T, s/n - Ilha', city: 'Florianópolis', state: 'SC', zip_code: '88000-123',
                   description: 'Batman é o melhor.', payment: 'PIX, Cartão de Débito, Cartão de Crédito',
                   owner: batman)

    Buffet.create!(brand_name: 'Os Cavaleiro dos Zodíacos', corporate_name: 'Saint Seiya LTDA',
                   registration_number: '12192017000312', phone: '11905051212', email: 'contato@saintseiya.com',
                   address: 'Estrada das 12 casas, 12 - Grécia', city: 'São Paulo', state: 'SP', zip_code: '01212005',
                   description: 'Venha elevar o seu cosmo conosco.', payment: 'Cartão de Débito, Cartão de Crédito',
                   owner: phoenix)

    visit root_path
    click_on 'Teenage Mutant Ninja Turtles'
    fill_in 'Buscar Buffet', with: 'São Paulo'
    click_on 'Buscar'

    expect(page).to have_content 'Resultado da busca por: São Paulo'
    expect(page).to have_content '2 Buffets encontrados'
    search = 'Os Cavaleiro dos Zodíacos | SP - São Paulo Teenage Mutant Ninja Turtles | SP - São Paulo'
    expect(page).to have_content search
    expect(page).not_to have_content 'Teen Titans | SC - Florianópolis'
  end

  it 'find buffet by Events' do
    owner = Owner.create!(name: 'Splinter', email: 'splinter@email.com', password: 'password')
    batman = Owner.create!(name: 'Bruce Wayne', email: 'bruce.wayne@dccomix.com', password: 'nanananana_batman!')
    phoenix = Owner.create!(name: 'Phoenix Ikki', email: 'phoenix.ikki@saint.com', password: 'phoenix.ikki123')

    buffet = Buffet.create!(brand_name: 'Teenage Mutant Ninja Turtles', corporate_name: 'TMNT Splinter LTDA',
                            registration_number: '88392017000182', phone: '11912341234',
                            email: 'contato@tmntsplinter.com', address: 'Rua Estados Unidos, 1030 - Jardins',
                            city: 'São Paulo', state: 'SP', zip_code: '01234123',
                            description: 'Melhor Buffet da região. Cowabunga', payment: 'PIX, Cartão de Débito', owner:)

    teen_titans = Buffet.create!(brand_name: 'Teen Titans', corporate_name: 'Justice League Teens',
                                 registration_number: '70849145000147', phone: '11900001111',
                                 email: 'contato@teentitans.com', address: 'Torre T, s/n - Ilha', city: 'Florianópolis',
                                 state: 'SC', zip_code: '88000-123', description: 'Batman é o melhor.',
                                 payment: 'PIX, Cartão de Débito, Cartão de Crédito', owner: batman)

    seiya = Buffet.create!(brand_name: 'Os Cavaleiro dos Zodíacos', corporate_name: 'Saint Seiya LTDA',
                           registration_number: '12192017000312', phone: '11905051212', email: 'contato@saintseiya.com',
                           address: 'Estrada das 12 casas, 12 - Grécia', city: 'São Paulo', state: 'SP',
                           zip_code: '01212005', description: 'Venha elevar o seu cosmo conosco.',
                           payment: 'Cartão de Débito, Cartão de Crédito', owner: phoenix)

    Event.create!(name: 'Festa infantil', description: 'Festa para crianças com temática TMNT', min_people: 10,
                  max_people: 100, duration: 300, menu: 'Pizza', alcoholic_beverages: false, decoration: true,
                  parking: true, parking_valet: false, customer_space: true, buffet:)
    Event.create!(name: 'Infantil festejando', description: 'Festa para crianças com temática TMNT', min_people: 10,
                  max_people: 100, duration: 300, menu: 'Pizza', alcoholic_beverages: false, decoration: true,
                  parking: true, parking_valet: false, customer_space: true, buffet: seiya)
    Event.create!(name: 'Festa de criança', description: 'Festa para crianças com temática TMNT', min_people: 10,
                  max_people: 100, duration: 300, menu: 'Pizza', alcoholic_beverages: false, decoration: true,
                  parking: true, parking_valet: false, customer_space: true, buffet: teen_titans)

    visit root_path
    click_on 'Teenage Mutant Ninja Turtles'
    click_on 'Festa infantil'
    fill_in 'Buscar Buffet', with: 'inFANtil'
    click_on 'Buscar'

    expect(page).to have_content 'Resultado da busca por: inFANtil'
    expect(page).to have_content '2 Buffets encontrados'
    search = 'Os Cavaleiro dos Zodíacos | SP - São Paulo Teenage Mutant Ninja Turtles | SP - São Paulo'
    expect(page).to have_content search
    expect(page).not_to have_content 'Teen Titans | SC - Florianópolis'
  end

  it 'find one buffet' do
    owner = Owner.create!(name: 'Splinter', email: 'splinter@email.com', password: 'password')

    Buffet.create!(brand_name: 'Teenage Mutant Ninja Turtles', corporate_name: 'TMNT Splinter LTDA',
                   registration_number: '88392017000182', phone: '11912341234', email: 'contato@tmntsplinter.com',
                   address: 'Rua Estados Unidos, 1030 - Jardins', city: 'São Paulo', state: 'SP', zip_code: '01234123',
                   description: 'Melhor Buffet da região. Cowabunga', payment: 'PIX, Cartão de Débito', owner:)

    visit root_path
    fill_in 'Buscar Buffet', with: 'Teenage'
    click_on 'Buscar'

    expect(page).to have_content 'Resultado da busca por: Teenage'
    expect(page).to have_content '1 Buffet encontrado'
    expect(page).to have_content 'Teenage Mutant Ninja Turtles | SP - São Paulo'
  end

  it 'if query is empty' do
    owner = Owner.create!(name: 'Splinter', email: 'splinter@email.com', password: 'password')
    batman = Owner.create!(name: 'Bruce Wayne', email: 'bruce.wayne@dccomix.com', password: 'nanananana_batman!')
    phoenix = Owner.create!(name: 'Phoenix Ikki', email: 'phoenix.ikki@saint.com', password: 'phoenix.ikki123')

    buffet = Buffet.create!(brand_name: 'Teenage Mutant Ninja Turtles', corporate_name: 'TMNT Splinter LTDA',
                            registration_number: '88392017000182', phone: '11912341234',
                            email: 'contato@tmntsplinter.com', address: 'Rua Estados Unidos, 1030 - Jardins',
                            city: 'São Paulo', state: 'SP', zip_code: '01234123',
                            description: 'Melhor Buffet da região. Cowabunga', payment: 'PIX, Cartão de Débito', owner:)

    teen_titans = Buffet.create!(brand_name: 'Teen Titans', corporate_name: 'Justice League Teens',
                                 registration_number: '70849145000147', phone: '11900001111',
                                 email: 'contato@teentitans.com', address: 'Torre T, s/n - Ilha', city: 'Florianópolis',
                                 state: 'SC', zip_code: '88000-123', description: 'Batman é o melhor.',
                                 payment: 'PIX, Cartão de Débito, Cartão de Crédito', owner: batman)

    seiya = Buffet.create!(brand_name: 'Os Cavaleiro dos Zodíacos', corporate_name: 'Saint Seiya LTDA',
                           registration_number: '12192017000312', phone: '11905051212', email: 'contato@saintseiya.com',
                           address: 'Estrada das 12 casas, 12 - Grécia', city: 'São Paulo', state: 'SP',
                           zip_code: '01212005', description: 'Venha elevar o seu cosmo conosco.',
                           payment: 'Cartão de Débito, Cartão de Crédito', owner: phoenix)

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
                  parking: true, parking_valet: false, customer_space: true, buffet: teen_titans)

    visit root_path
    fill_in 'Buscar Buffet', with: ''
    click_on 'Buscar'

    expect(page).to have_content 'Resultado da busca por:'
    expect(page).to have_content '3 Buffets encontrados'
    search = 'Os Cavaleiro dos Zodíacos | SP - São Paulo Teen Titans | SC - Florianópolis Teenage Mutant Ninja Turtles | SP - São Paulo'
    expect(page).to have_content search
  end

  it 'cannot repeat buffet' do
    owner = Owner.create!(name: 'Splinter', email: 'splinter@email.com', password: 'password')
    batman = Owner.create!(name: 'Bruce Wayne', email: 'bruce.wayne@dccomix.com', password: 'nanananana_batman!')
    phoenix = Owner.create!(name: 'Phoenix Ikki', email: 'phoenix.ikki@saint.com', password: 'phoenix.ikki123')

    buffet = Buffet.create!(brand_name: 'Teenage Mutant Ninja Turtles', corporate_name: 'TMNT Splinter LTDA',
                            registration_number: '88392017000182', phone: '11912341234',
                            email: 'contato@tmntsplinter.com', address: 'Rua Estados Unidos, 1030 - Jardins',
                            city: 'São Paulo', state: 'SP', zip_code: '01234123',
                            description: 'Melhor Buffet da região. Cowabunga', payment: 'PIX, Cartão de Débito', owner:)

    teen_titans = Buffet.create!(brand_name: 'Teen Titans', corporate_name: 'Justice League Teens',
                                 registration_number: '70849145000147', phone: '11900001111',
                                 email: 'contato@teentitans.com', address: 'Torre T, s/n - Ilha', city: 'Florianópolis',
                                 state: 'SC', zip_code: '88000-123', description: 'Batman é o melhor.',
                                 payment: 'PIX, Cartão de Débito, Cartão de Crédito', owner: batman)

    seiya = Buffet.create!(brand_name: 'Os Cavaleiro dos Zodíacos', corporate_name: 'Saint Seiya LTDA',
                           registration_number: '12192017000312', phone: '11905051212', email: 'contato@saintseiya.com',
                           address: 'Estrada das 12 casas, 12 - Grécia', city: 'São Paulo', state: 'SP',
                           zip_code: '01212005', description: 'Venha elevar o seu cosmo conosco.',
                           payment: 'Cartão de Débito, Cartão de Crédito', owner: phoenix)

    Event.create!(name: 'Festa infantil', description: 'Festa para crianças com temática TMNT', min_people: 10,
                  max_people: 100, duration: 300, menu: 'Pizza', alcoholic_beverages: false, decoration: true,
                  parking: true, parking_valet: false, customer_space: true, buffet:)
    Event.create!(name: 'Infantil festejando', description: 'Festa para crianças com temática TMNT', min_people: 10,
                  max_people: 100, duration: 300, menu: 'Pizza', alcoholic_beverages: false, decoration: true,
                  parking: true, parking_valet: false, customer_space: true, buffet: seiya)
    Event.create!(name: 'Festa de criança', description: 'Festa para crianças com temática TMNT', min_people: 10,
                  max_people: 100, duration: 300, menu: 'Pizza', alcoholic_beverages: false, decoration: true,
                  parking: true, parking_valet: false, customer_space: true, buffet: teen_titans)

    visit root_path
    fill_in 'Buscar Buffet', with: 't'
    click_on 'Buscar'

    expect(page).to have_content 'Resultado da busca por:'
    expect(page).to have_content '3 Buffets encontrados'
    search = 'Os Cavaleiro dos Zodíacos | SP - São Paulo Teen Titans | SC - Florianópolis Teenage Mutant Ninja Turtles | SP - São Paulo'
    expect(page).to have_content search
  end
end
