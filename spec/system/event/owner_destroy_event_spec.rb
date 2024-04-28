require 'rails_helper'

describe 'Owner destroy event' do
  it 'if authenticated' do
    owner = Owner.create!(name: 'Splinter', email: 'splinter@email.com', password: 'password')

    buffet = Buffet.create!(brand_name: 'TMNT Buffet', payment: 'PIX', owner:)

    Event.create!(name: 'Festa infantil', description: 'Festa para crianças com temática TMNT', min_people: 10,
                  max_people: 100, duration: 300, menu: 'Pizza', alcoholic_beverages: false, decoration: true,
                  parking: true, parking_valet: false, customer_space: true, buffet:)

    visit root_path
    click_on 'TMNT Buffet'
    click_on 'Festa infantil'

    expect(page).not_to have_content 'Excluir Evento'
  end

  it 'successfully' do
    owner = Owner.create!(name: 'Splinter', email: 'splinter@email.com', password: 'password')

    buffet = Buffet.create!(brand_name: 'TMNT Buffet', payment: 'PIX', owner:)

    Event.create!(name: 'Festa infantil', description: 'Festa para crianças com temática TMNT', min_people: 10,
                  max_people: 100, duration: 300, menu: 'Pizza', alcoholic_beverages: false, decoration: true,
                  parking: true, parking_valet: false, customer_space: true, buffet:)
    Event.create!(name: 'Festa de casamento', description: 'Festa de casamento dos sonhos', min_people: 10,
                  max_people: 100, duration: 300, menu: 'Pizza', alcoholic_beverages: true, decoration: true,
                  parking: true, parking_valet: true, customer_space: true, buffet:)

    login_as owner
    visit root_path
    click_on 'TMNT Buffet'
    click_on 'Festa infantil'
    click_on 'Excluir Evento'

    expect(current_path).to eq buffet_path(buffet)
    expect(page).to have_content 'Festa infantil excluído(a) com sucesso'
    within('section#events') do
      expect(page).to have_content 'Festa de casamento'
      expect(page).not_to have_content 'Festa infantil'
    end
    expect(Event.count).to eq 1
  end
end
