require 'rails_helper'

describe 'Owner edit events' do
  it 'if authenticated' do
    owner = Owner.create!(name: 'Splinter', email: 'splinter@email.com', password: 'password')

    buffet = Buffet.create!(brand_name: 'Teenage Mutant Ninja Turtles', corporate_name: 'TMNT Splinter LTDA',
                            registration_number: '88392017000182', phone: '11912341234',
                            email: 'contato@tmntsplinter.com', address: 'Rua Estados Unidos, 1030 - Jardins',
                            city: 'São Paulo', state: 'SP', zip_code: '01234123',
                            description: 'Melhor Buffet da região. Cowabunga', payment: 'PIX, Cartão de Débito', owner:)

    Event.create!(name: 'Festa infantil', description: 'Festa para crianças com temática TMNT', min_people: 10,
                  max_people: 100, duration: 300, menu: 'Pizza', alcoholic_beverages: false, decoration: true,
                  parking: true, parking_valet: false, customer_space: true, buffet:)

    visit root_path
    click_on 'Teenage Mutant Ninja Turtles'
    click_on 'Festa infantil'

    expect(page).not_to have_content 'Editar Evento'
  end

  it 'from homepage' do
    owner = Owner.create!(name: 'Splinter', email: 'splinter@email.com', password: 'password')

    buffet = Buffet.create!(brand_name: 'Teenage Mutant Ninja Turtles', corporate_name: 'TMNT Splinter LTDA',
                            registration_number: '88392017000182', phone: '11912341234',
                            email: 'contato@tmntsplinter.com', address: 'Rua Estados Unidos, 1030 - Jardins',
                            city: 'São Paulo', state: 'SP', zip_code: '01234123',
                            description: 'Melhor Buffet da região. Cowabunga', payment: 'PIX, Cartão de Débito', owner:)

    Event.create!(name: 'Festa infantil', description: 'Festa para crianças com temática TMNT', min_people: 10,
                  max_people: 100, duration: 300, menu: 'Pizza', alcoholic_beverages: false, decoration: true,
                  parking: true, parking_valet: false, customer_space: true, buffet:)

    login_as owner, scope: :owner
    visit root_path
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

    buffet = Buffet.create!(brand_name: 'Teenage Mutant Ninja Turtles', corporate_name: 'TMNT Splinter LTDA',
                            registration_number: '88392017000182', phone: '11912341234',
                            email: 'contato@tmntsplinter.com', address: 'Rua Estados Unidos, 1030 - Jardins',
                            city: 'São Paulo', state: 'SP', zip_code: '01234123',
                            description: 'Melhor Buffet da região. Cowabunga', payment: 'PIX, Cartão de Débito', owner:)

    Event.create!(name: 'Festa de casamento', description: 'Festa de casamento dos sonhos', min_people: 10,
                  max_people: 100, duration: 420, menu: 'Pizza', alcoholic_beverages: true, decoration: true,
                  parking: true, parking_valet: true, customer_space: true, buffet:)

    login_as owner, scope: :owner
    visit root_path
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

  it 'and leaves some fields blank' do
    owner = Owner.create!(name: 'Splinter', email: 'splinter@email.com', password: 'password')

    buffet = Buffet.create!(brand_name: 'Teenage Mutant Ninja Turtles', corporate_name: 'TMNT Splinter LTDA',
                            registration_number: '88392017000182', phone: '11912341234',
                            email: 'contato@tmntsplinter.com', address: 'Rua Estados Unidos, 1030 - Jardins',
                            city: 'São Paulo', state: 'SP', zip_code: '01234123',
                            description: 'Melhor Buffet da região. Cowabunga', payment: 'PIX, Cartão de Débito', owner:)

    Event.create!(name: 'Festa de casamento', description: 'Festa de casamento dos sonhos', min_people: 10,
                  max_people: 100, duration: 420, menu: 'Pizza', alcoholic_beverages: true, decoration: false,
                  parking: false, parking_valet: false, customer_space: false, buffet:)

    login_as owner, scope: :owner
    visit root_path
    click_on 'Festa de casamento'
    click_on 'Editar Evento'
    fill_in 'Nome',	with: ''
    fill_in 'Descrição',	with: ''
    fill_in 'Mínimo de pessoas',	with: ''
    fill_in 'Máximo de pessoas', with: ''
    fill_in 'Duração',	with: ''
    fill_in 'Cardápio', with: ''
    click_on 'Atualizar Evento'

    expect(page).to have_content 'Atente-se aos erros abaixo:'
    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'Descrição não pode ficar em branco'
    expect(page).to have_content 'Mínimo de pessoas não pode ficar em branco'
    expect(page).to have_content 'Mínimo de pessoas deve ser positivo'
    expect(page).to have_content 'Máximo de pessoas não pode ficar em branco'
    expect(page).to have_content 'Máximo de pessoas deve ser positivo'
    expect(page).to have_content 'Duração não pode ficar em branco'
    expect(page).to have_content 'Duração deve ser positivo'
    expect(page).to have_content 'Cardápio não pode ficar em branco'
  end

  it 'numbers must be positive' do
    owner = Owner.create!(name: 'Splinter', email: 'splinter@email.com', password: 'password')

    buffet = Buffet.create!(brand_name: 'Teenage Mutant Ninja Turtles', corporate_name: 'TMNT Splinter LTDA',
                            registration_number: '88392017000182', phone: '11912341234',
                            email: 'contato@tmntsplinter.com', address: 'Rua Estados Unidos, 1030 - Jardins',
                            city: 'São Paulo', state: 'SP', zip_code: '01234123',
                            description: 'Melhor Buffet da região. Cowabunga', payment: 'PIX, Cartão de Débito', owner:)

    Event.create!(name: 'Festa de casamento', description: 'Festa de casamento dos sonhos', min_people: 10,
                  max_people: 100, duration: 420, menu: 'Pizza', alcoholic_beverages: true, decoration: false,
                  parking: false, parking_valet: false, customer_space: false, buffet:)

    login_as owner, scope: :owner
    visit root_path
    click_on 'Festa de casamento'
    click_on 'Editar Evento'
    fill_in 'Mínimo de pessoas',	with: '-1'
    fill_in 'Máximo de pessoas', with: '-1'
    fill_in 'Duração',	with: '-1'
    click_on 'Atualizar Evento'

    expect(page).to have_content 'Atente-se aos erros abaixo:'
    expect(page).to have_content 'Mínimo de pessoas deve ser positivo'
    expect(page).to have_content 'Máximo de pessoas deve ser positivo'
    expect(page).to have_content 'Duração deve ser positivo'
    expect(page).not_to have_content 'Mínimo de pessoas não pode ficar em branco'
    expect(page).not_to have_content 'Máximo de pessoas não pode ficar em branco'
    expect(page).not_to have_content 'Duração não pode ficar em branco'
  end

  it 'if it is yours' do
    owner = Owner.create!(name: 'Splinter', email: 'splinter@email.com', password: 'password')
    phoenix = Owner.create!(name: 'Phoenix Ikki', email: 'phoenix.ikki@saint.com', password: 'phoenix.ikki123')

    buffet = Buffet.create!(brand_name: 'Teenage Mutant Ninja Turtles', corporate_name: 'TMNT Splinter LTDA',
                            registration_number: '88392017000182', phone: '11912341234',
                            email: 'contato@tmntsplinter.com', address: 'Rua Estados Unidos, 1030 - Jardins',
                            city: 'São Paulo', state: 'SP', zip_code: '01234123',
                            description: 'Melhor Buffet da região. Cowabunga', payment: 'PIX, Cartão de Débito', owner:)

    saint_seiya = Buffet.create!(brand_name: 'Os Cavaleiro dos Zodíacos', corporate_name: 'Saint Seiya LTDA',
                                 registration_number: '12192017000312', phone: '11905051212',
                                 email: 'contato@saintseiya.com', address: 'Estrada das 12 casas, 12 - Grécia',
                                 city: 'São Paulo', state: 'SP', zip_code: '01212005',
                                 description: 'Venha elevar o seu cosmo conosco.',
                                 payment: 'PIX, Cartão de Débito, Cartão de Crédito', owner: phoenix)

    event = Event.create!(name: 'Festa de casamento', description: 'Festa de casamento dos sonhos', min_people: 10,
                          max_people: 100, duration: 420, menu: 'Pizza', alcoholic_beverages: true, decoration: false,
                          parking: false, parking_valet: false, customer_space: false, buffet:)

    login_as phoenix, scope: :owner
    visit edit_event_path(event)

    expect(current_path).to eq buffet_path saint_seiya
  end

  it 'back button to Event' do
    owner = Owner.create!(name: 'Splinter', email: 'splinter@email.com', password: 'password')

    buffet = Buffet.create!(brand_name: 'Teenage Mutant Ninja Turtles', corporate_name: 'TMNT Splinter LTDA',
                            registration_number: '88392017000182', phone: '11912341234',
                            email: 'contato@tmntsplinter.com', address: 'Rua Estados Unidos, 1030 - Jardins',
                            city: 'São Paulo', state: 'SP', zip_code: '01234123',
                            description: 'Melhor Buffet da região. Cowabunga', payment: 'PIX, Cartão de Débito', owner:)

    event = Event.create!(name: 'Festa de casamento', description: 'Festa de casamento dos sonhos', min_people: 10,
                          max_people: 100, duration: 420, menu: 'Pizza', alcoholic_beverages: true, decoration: false,
                          parking: false, parking_valet: false, customer_space: false, buffet:)

    login_as owner, scope: :owner
    visit root_path
    click_on 'Festa de casamento'
    click_on 'Editar Evento'
    click_on 'Voltar para Evento'

    expect(current_path).to eq event_path(event)
  end
end
