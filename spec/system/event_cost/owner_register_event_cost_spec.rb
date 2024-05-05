require 'rails_helper'

describe 'Owner register event cost' do
  it 'from homepage' do
    owner = Owner.create!(name: 'Splinter', email: 'splinter@email.com', password: 'password')

    buffet = Buffet.create!(brand_name: 'TMNT Buffet', payment: 'PIX', owner:)

    Event.create!(name: 'Festa de casamento', description: 'Festa de casamento dos sonhos', min_people: 10,
                  max_people: 100, duration: 420, menu: 'Pizza', alcoholic_beverages: true, decoration: true,
                  parking: true, parking_valet: true, customer_space: true, buffet:)

    login_as owner, scope: :owner
    visit root_path
    click_on 'TMNT Buffet'
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

    buffet = Buffet.create!(brand_name: 'TMNT Buffet', payment: 'PIX', owner:)

    Event.create!(name: 'Festa de casamento', description: 'Festa de casamento dos sonhos', min_people: 10,
                  max_people: 100, duration: 420, menu: 'Pizza', alcoholic_beverages: true, decoration: true,
                  parking: true, parking_valet: true, customer_space: true, buffet:)

    login_as owner, scope: :owner
    visit root_path
    click_on 'TMNT Buffet'
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
end
