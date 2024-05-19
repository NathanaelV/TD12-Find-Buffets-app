require 'rails_helper'

describe 'Buffet owner register event' do
  it 'from homepage' do
    owner = Owner.create!(name: 'Splinter', email: 'splinter@email.com', password: 'password')
    Buffet.create!(brand_name: 'Teenage Mutant Ninja Turtles', corporate_name: 'TMNT Splinter LTDA',
                   registration_number: '88392017000182', phone: '11912341234',
                   email: 'contato@tmntsplinter.com', address: 'Rua Estados Unidos, 1030 - Jardins',
                   city: 'São Paulo', state: 'SP', zip_code: '01234123',
                   description: 'Melhor Buffet da região. Cowabunga', payment: 'PIX, Cartão de Débito', owner:)

    login_as owner, scope: :owner
    visit root_path
    click_on 'Teenage Mutant Ninja Turtles'
    click_on 'Criar Evento'

    expect(page).to have_content 'Cadastrar Evento'
    expect(page).to have_field 'Nome', type: 'text'
    expect(page).to have_field 'Descrição', type: 'text'
    expect(page).to have_field 'Mínimo de pessoas', type: 'number'
    expect(page).to have_field 'Máximo de pessoas', type: 'number'
    expect(page).to have_field 'Duração', type: 'number'
    expect(page).to have_field 'Cardápio', type: 'text'
    expect(page).to have_unchecked_field 'Bebidas alcoólicas'
    expect(page).to have_unchecked_field 'Decoração'
    expect(page).to have_unchecked_field 'Serviço de estacionamento'
    expect(page).to have_unchecked_field 'Serviço de Valet'
    expect(page).to have_unchecked_field 'Evento em residência'
  end

  it 'successfully' do
    owner = Owner.create!(name: 'Splinter', email: 'splinter@email.com', password: 'password')

    Buffet.create!(brand_name: 'Teenage Mutant Ninja Turtles', corporate_name: 'TMNT Splinter LTDA',
                   registration_number: '88392017000182', phone: '11912341234',
                   email: 'contato@tmntsplinter.com', address: 'Rua Estados Unidos, 1030 - Jardins',
                   city: 'São Paulo', state: 'SP', zip_code: '01234123',
                   description: 'Melhor Buffet da região. Cowabunga', payment: 'PIX, Cartão de Débito', owner:)

    login_as owner, scope: :owner
    visit root_path
    click_on 'Teenage Mutant Ninja Turtles'
    click_on 'Criar Evento'
    fill_in 'Nome',	with: 'Festa infantil'
    fill_in 'Descrição',	with: 'Festa para crianças com temática TMNT'
    fill_in 'Mínimo de pessoas',	with: '10'
    fill_in 'Máximo de pessoas', with: '100'
    fill_in 'Duração',	with: '300'
    fill_in 'Cardápio', with: 'Pizza'
    check 'Bebidas alcoólicas'
    check 'Decoração'
    check 'Serviço de estacionamento'
    check 'Serviço de Valet'
    check 'Evento em residência'
    click_on 'Criar Evento'

    expect(page).to have_content 'Evento criado com sucesso!'
    expect(page).to have_content 'Festa infantil'
    expect(page).to have_content 'Festa para crianças com temática TMNT'
    expect(page).to have_content 'Mínimo de pessoas: 10'
    expect(page).to have_content 'Máximo de pessoas: 100'
    expect(page).to have_content 'Duração 300 min'
    expect(page).to have_content 'Cardápio: Pizza'
    expect(page).to have_content 'Bebidas alcoólicas'
    expect(page).to have_content 'Decoração'
    expect(page).to have_content 'Serviço de estacionamento'
    expect(page).to have_content 'Serviço de Valet'
    expect(page).to have_content 'Evento em residência'
  end

  it 'and leaves some fields blank' do
    owner = Owner.create!(name: 'Splinter', email: 'splinter@email.com', password: 'password')

    Buffet.create!(brand_name: 'Teenage Mutant Ninja Turtles', corporate_name: 'TMNT Splinter LTDA',
                   registration_number: '88392017000182', phone: '11912341234',
                   email: 'contato@tmntsplinter.com', address: 'Rua Estados Unidos, 1030 - Jardins',
                   city: 'São Paulo', state: 'SP', zip_code: '01234123',
                   description: 'Melhor Buffet da região. Cowabunga', payment: 'PIX, Cartão de Débito', owner:)

    login_as owner, scope: :owner
    visit root_path
    click_on 'Teenage Mutant Ninja Turtles'
    click_on 'Criar Evento'
    fill_in 'Nome',	with: ''
    fill_in 'Descrição',	with: ''
    fill_in 'Mínimo de pessoas',	with: ''
    fill_in 'Máximo de pessoas', with: ''
    fill_in 'Duração',	with: ''
    fill_in 'Cardápio', with: ''
    click_on 'Criar Evento'

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

    Buffet.create!(brand_name: 'Teenage Mutant Ninja Turtles', corporate_name: 'TMNT Splinter LTDA',
                   registration_number: '88392017000182', phone: '11912341234',
                   email: 'contato@tmntsplinter.com', address: 'Rua Estados Unidos, 1030 - Jardins',
                   city: 'São Paulo', state: 'SP', zip_code: '01234123',
                   description: 'Melhor Buffet da região. Cowabunga', payment: 'PIX, Cartão de Débito', owner:)

    login_as owner, scope: :owner
    visit root_path
    click_on 'Teenage Mutant Ninja Turtles'
    click_on 'Criar Evento'
    fill_in 'Mínimo de pessoas',	with: '-1'
    fill_in 'Máximo de pessoas', with: '-1'
    fill_in 'Duração',	with: '-1'
    click_on 'Criar Evento'

    expect(page).to have_content 'Atente-se aos erros abaixo:'
    expect(page).to have_content 'Mínimo de pessoas deve ser positivo'
    expect(page).to have_content 'Máximo de pessoas deve ser positivo'
    expect(page).to have_content 'Duração deve ser positivo'
    expect(page).not_to have_content 'Mínimo de pessoas não pode ficar em branco'
    expect(page).not_to have_content 'Máximo de pessoas não pode ficar em branco'
    expect(page).not_to have_content 'Duração não pode ficar em branco'
  end

  xit 'if it is yours' do
  end
end
