require 'rails_helper'

describe 'Owner view event cost' do
  it 'successfully' do
    owner = Owner.create!(name: 'Splinter', email: 'splinter@email.com', password: 'password')

    buffet = Buffet.create!(brand_name: 'TMNT Buffet', payment: 'PIX', owner:)

    event = Event.create!(name: 'Festa de casamento', description: 'Festa de casamento dos sonhos', min_people: 10,
                          max_people: 100, duration: 420, menu: 'Pizza', alcoholic_beverages: true, decoration: true,
                          parking: true, parking_valet: true, customer_space: true, buffet:)

    EventCost.create!(description: 'Dias de semana', minimum: 2_000, additional_per_person: 70, overtime: 1000, event:)
    EventCost.create!(description: 'Fim de semana', minimum: 4_000, additional_per_person: 140, overtime: 2000, event:)

    login_as owner, scope: :owner
    visit root_path
    click_on 'TMNT Buffet'
    click_on 'Festa de casamento'

    expect(page).to have_content 'Valores'
    expect(page).to have_content 'Dias de semana'
    expect(page).to have_content 'Valor inicial: 2000'
    expect(page).to have_content 'Preço adicional: 70/pessoa'
    expect(page).to have_content 'Hora extra: 1000/hora'
    expect(page).to have_content 'Dias de semana'
    expect(page).to have_content 'Valor inicial: 4000'
    expect(page).to have_content 'Preço adicional: 140/pessoa'
    expect(page).to have_content 'Hora extra: 2000/hora'
  end
end
