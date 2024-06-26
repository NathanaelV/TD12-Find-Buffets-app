require 'rails_helper'

describe 'Owner update Event Cost' do
  it 'from homepage' do
    owner = Owner.create!(name: 'Splinter', email: 'splinter@email.com', password: 'password')

    buffet = Buffet.create!(brand_name: 'Teenage Mutant Ninja Turtles', corporate_name: 'TMNT Splinter LTDA',
                            registration_number: '88392017000182', phone: '11912341234',
                            email: 'contato@tmntsplinter.com', address: 'Rua Estados Unidos, 1030 - Jardins',
                            city: 'São Paulo', state: 'SP', zip_code: '01234123',
                            description: 'Melhor Buffet da região. Cowabunga', payment: 'PIX, Cartão de Débito', owner:)

    event = Event.create!(name: 'Festa de casamento', description: 'Festa de casamento dos sonhos', min_people: 10,
                          max_people: 100, duration: 420, menu: 'Pizza', alcoholic_beverages: true, decoration: true,
                          parking: true, parking_valet: true, customer_space: true, buffet:)

    EventCost.create!(description: 'Dias de semana', minimum: 2_000, additional_per_person: 70, overtime: 1000, event:)
    EventCost.create!(description: 'Fim de semana', minimum: 4_000, additional_per_person: 140, overtime: 2000, event:)

    login_as owner, scope: :owner
    visit root_path
    click_on 'Festa de casamento'
    within('div#dias-de-semana') do
      click_on 'Editar'
    end

    expect(page).to have_content 'Editar Dias de semana'
    expect(page).to have_field 'Descrição', with: 'Dias de semana'
    expect(page).to have_field 'Valor mínimo', with: '2000'
    expect(page).to have_field 'Valor adicional por pessoa', with: '70'
    expect(page).to have_field 'Hora extra', with: '1000'
    expect(page).not_to have_content 'Atente-se aos erros abaixo:'
  end

  it 'successfully' do
    owner = Owner.create!(name: 'Splinter', email: 'splinter@email.com', password: 'password')

    buffet = Buffet.create!(brand_name: 'Teenage Mutant Ninja Turtles', corporate_name: 'TMNT Splinter LTDA',
                            registration_number: '88392017000182', phone: '11912341234',
                            email: 'contato@tmntsplinter.com', address: 'Rua Estados Unidos, 1030 - Jardins',
                            city: 'São Paulo', state: 'SP', zip_code: '01234123',
                            description: 'Melhor Buffet da região. Cowabunga', payment: 'PIX, Cartão de Débito', owner:)

    event = Event.create!(name: 'Festa de casamento', description: 'Festa de casamento dos sonhos', min_people: 10,
                          max_people: 100, duration: 420, menu: 'Pizza', alcoholic_beverages: true, decoration: true,
                          parking: true, parking_valet: true, customer_space: true, buffet:)

    EventCost.create!(description: 'Dias de semana', minimum: 2_000, additional_per_person: 70, overtime: 1000, event:)
    EventCost.create!(description: 'Fim de semana', minimum: 4_000, additional_per_person: 140, overtime: 2000, event:)

    login_as owner, scope: :owner
    visit root_path
    click_on 'Festa de casamento'
    within('div#dias-de-semana') do
      click_on 'Editar'
    end
    fill_in 'Descrição', with: 'Feriados'
    fill_in 'Valor mínimo', with: '5000'
    fill_in 'Valor adicional por pessoa', with: '200'
    fill_in 'Hora extra', with: '2500'
    click_on 'Atualizar Custo do Evento'

    expect(page).to have_content 'Custo do evento atualizado com sucesso.'
    expect(page).to have_content 'Feriados'
    expect(page).to have_content '5000'
    expect(page).to have_content '200'
    expect(page).to have_content '2500'
  end

  it 'and leaves some fields blank' do
    owner = Owner.create!(name: 'Splinter', email: 'splinter@email.com', password: 'password')

    buffet = Buffet.create!(brand_name: 'Teenage Mutant Ninja Turtles', corporate_name: 'TMNT Splinter LTDA',
                            registration_number: '88392017000182', phone: '11912341234',
                            email: 'contato@tmntsplinter.com', address: 'Rua Estados Unidos, 1030 - Jardins',
                            city: 'São Paulo', state: 'SP', zip_code: '01234123',
                            description: 'Melhor Buffet da região. Cowabunga', payment: 'PIX, Cartão de Débito', owner:)

    event = Event.create!(name: 'Festa de casamento', description: 'Festa de casamento dos sonhos', min_people: 10,
                          max_people: 100, duration: 420, menu: 'Pizza', alcoholic_beverages: true, decoration: true,
                          parking: true, parking_valet: true, customer_space: true, buffet:)

    EventCost.create!(description: 'Dias de semana', minimum: 2_000, additional_per_person: 70, overtime: 1000, event:)
    EventCost.create!(description: 'Fim de semana', minimum: 4_000, additional_per_person: 140, overtime: 2000, event:)

    login_as owner, scope: :owner
    visit root_path
    click_on 'Festa de casamento'
    within '#dias-de-semana' do
      click_on 'Editar'
    end
    fill_in 'Descrição',	with: ''
    fill_in 'Valor mínimo',	with: ''
    fill_in 'Valor adicional por pessoa',	with: ''
    fill_in 'Hora extra',	with: ''
    click_on 'Atualizar Custo do Evento'

    expect(page).to have_content 'Atente-se aos erros abaixo:'
    expect(page).to have_content 'Descrição não pode ficar em branco'
    expect(page).to have_content 'Valor mínimo não pode ficar em branco'
    expect(page).to have_content 'Valor mínimo deve ser positivo'
    expect(page).to have_content 'Valor adicional por pessoa não pode ficar em branco'
    expect(page).to have_content 'Valor adicional por pessoa deve ser positivo'
    expect(page).to have_content 'Hora extra não pode ficar em branco'
    expect(page).to have_content 'Hora extra deve ser positivo'
    expect(page).not_to have_content 'Evento é obrigatório(a)'
  end

  it 'if it yours' do
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

    event_cost = EventCost.create!(description: 'Dias de semana', minimum: 2_000, additional_per_person: 70,
                                   overtime: 1000, event:)

    login_as phoenix, scope: :owner
    visit edit_event_event_cost_path(event, event_cost)

    expect(current_path).to eq buffet_path saint_seiya
  end

  it 'back button Event' do
    owner = Owner.create!(name: 'Splinter', email: 'splinter@email.com', password: 'password')

    buffet = Buffet.create!(brand_name: 'Teenage Mutant Ninja Turtles', corporate_name: 'TMNT Splinter LTDA',
                            registration_number: '88392017000182', phone: '11912341234',
                            email: 'contato@tmntsplinter.com', address: 'Rua Estados Unidos, 1030 - Jardins',
                            city: 'São Paulo', state: 'SP', zip_code: '01234123',
                            description: 'Melhor Buffet da região. Cowabunga', payment: 'PIX, Cartão de Débito', owner:)

    event = Event.create!(name: 'Festa de casamento', description: 'Festa de casamento dos sonhos', min_people: 10,
                          max_people: 100, duration: 420, menu: 'Pizza', alcoholic_beverages: true, decoration: true,
                          parking: true, parking_valet: true, customer_space: true, buffet:)

    EventCost.create!(description: 'Dias de semana', minimum: 2_000, additional_per_person: 70, overtime: 1000, event:)

    login_as owner, scope: :owner
    visit root_path
    click_on 'Festa de casamento'
    within '#dias-de-semana' do
      click_on 'Editar'
    end
    click_on 'Voltar para Evento'

    expect(current_path).to eq event_path(event)
  end
end
