require 'rails_helper'

describe 'Owner register event cost' do
  it 'from homepage' do
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
    click_on 'Adicionar Custos do Evento'

    expect(page).to have_content 'Adicionar custos do evento'
    expect(page).to have_field 'Descrição'
    expect(page).to have_field 'Valor mínimo'
    expect(page).to have_field 'Valor adicional por pessoa'
    expect(page).to have_field 'Hora extra'
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
    click_on 'Adicionar Custos do Evento'
    fill_in 'Descrição',	with: 'Fim de semana'
    fill_in 'Valor mínimo', with: '2000'
    fill_in 'Valor adicional por pessoa', with: '70'
    fill_in 'Hora extra', with: '1000'
    click_on 'Criar Custo do Evento'

    expect(page).to have_content 'Custo do evento criado com sucesso.'
    expect(page).to have_content 'Valores'
    expect(page).to have_content 'Fim de semana'
    expect(page).to have_content 'Valor inicial: 2000'
    expect(page).to have_content 'Preço adicional: 70/pessoa'
    expect(page).to have_content 'Hora extra: 1000/hora'
  end

  it 'and leaves some fields blank' do
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
    click_on 'Adicionar Custos do Evento'
    fill_in 'Descrição',	with: ''
    click_on 'Criar Custo do Evento'

    expect(page).to have_content 'Atente-se aos erros abaixo:'
    expect(page).to have_content 'Descrição não pode ficar em branco'
    expect(page).to have_content 'Valor mínimo não pode ficar em branco'
    expect(page).to have_content 'Valor adicional por pessoa não pode ficar em branco'
    expect(page).to have_content 'Hora extra não pode ficar em branco'
    expect(page).not_to have_content 'Evento é obrigatório(a)'
  end

  it 'numbers cannot be negative' do
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
    click_on 'Adicionar Custos do Evento'
    fill_in 'Descrição', with: 'Fim de semana'
    fill_in 'Valor mínimo',	with: '-1'
    fill_in 'Valor adicional por pessoa',	with: '-1'
    fill_in 'Hora extra',	with: '-1'
    click_on 'Criar Custo do Evento'

    expect(page).to have_content 'Atente-se aos erros abaixo:'
    expect(page).to have_content 'Valor mínimo deve ser positivo'
    expect(page).to have_content 'Valor adicional por pessoa deve ser positivo'
    expect(page).to have_content 'Hora extra deve ser positivo'
    expect(page).not_to have_content 'Descrição não pode ficar em branco'
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

    EventCost.create!(description: 'Dias de semana', minimum: 2_000, additional_per_person: 70, overtime: 1000, event:)

    login_as phoenix, scope: :owner
    visit new_event_event_cost_path(event)

    expect(current_path).to eq buffet_path saint_seiya
  end

  it 'and click on back button to Event' do
    owner = Owner.create!(name: 'Splinter', email: 'splinter@email.com', password: 'password')

    buffet = Buffet.create!(brand_name: 'Teenage Mutant Ninja Turtles', corporate_name: 'TMNT Splinter LTDA',
                            registration_number: '88392017000182', phone: '11912341234',
                            email: 'contato@tmntsplinter.com', address: 'Rua Estados Unidos, 1030 - Jardins',
                            city: 'São Paulo', state: 'SP', zip_code: '01234123',
                            description: 'Melhor Buffet da região. Cowabunga', payment: 'PIX, Cartão de Débito', owner:)

    event = Event.create!(name: 'Festa de casamento', description: 'Festa de casamento dos sonhos', min_people: 10,
                          max_people: 100, duration: 420, menu: 'Pizza', alcoholic_beverages: true, decoration: true,
                          parking: true, parking_valet: true, customer_space: true, buffet:)

    login_as owner, scope: :owner
    visit root_path
    click_on 'Festa de casamento'
    click_on 'Adicionar Custos do Evento'
    click_on 'Voltar para Evento'

    expect(current_path).to eq event_path(event)
  end
end

#                Prefix Verb  URI Pattern                                      Controller#Action
#     event_event_costs POST  /events/:event_id/event_costs(.:format)          event_costs#create
#  new_event_event_cost GET   /events/:event_id/event_costs/new(.:format)      event_costs#new
# edit_event_event_cost GET   /events/:event_id/event_costs/:id/edit(.:format) event_costs#edit
#      event_event_cost PATCH /events/:event_id/event_costs/:id(.:format)      event_costs#update
#                       PUT   /events/:event_id/event_costs/:id(.:format)      event_costs#update
#                             /*unmatched(.:format)                            errors#error404