require 'rails_helper'

describe 'Visitor authorization for events' do
  context "show" do
    it 'from homepage' do
      owner = Owner.create!(name: 'Donatello Yoshi', email: 'donatello.yoshi@email.com', password: 'donatello123')
  
      buffet = Buffet.create!(brand_name: 'TMNT Buffet', payment: 'PIX', owner:)
  
      Event.create!(name: 'Festa infantil', description: 'Festa para crianças com temática TMNT', min_people: 10,
                    max_people: 100, duration: 300, menu: 'Pizza', alcoholic_beverages: false, decoration: true,
                    parking: true, parking_valet: false, customer_space: true, buffet:)
  
      visit root_path
      click_on 'TMNT Buffet'
      click_on 'Festa infantil'
  
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
  end
  
  context 'visitor cannot create event ' do
    it 'from homepage' do
      owner = Owner.create!(name: 'Splinter', email: 'splinter@email.com', password: 'password')

      Buffet.create!(brand_name: 'TMNT Buffet', payment: 'PIX', owner:)

      visit root_path
      click_on 'TMNT Buffet'

      expect(page).not_to have_content 'Criar Evento'
    end
    
    it 'trying by URL' do
      owner = Owner.create!(name: 'Splinter', email: 'splinter@email.com', password: 'password')

      Buffet.create!(brand_name: 'TMNT Buffet', payment: 'PIX', owner:)

      visit new_event_path

      expect(current_path).not_to eq new_event_path
      expect(current_path).to eq new_owner_session_path
    end
  end

  context "visitor cannot edit event" do
    it 'from homepage' do
      owner = Owner.create!(name: 'Splinter', email: 'splinter@email.com', password: 'password')

      buffet = Buffet.create!(brand_name: 'TMNT Buffet', payment: 'PIX', owner:)

      Event.create!(name: 'Festa infantil', description: 'Festa para crianças com temática TMNT', min_people: 10,
                    max_people: 100, duration: 300, menu: 'Pizza', alcoholic_beverages: false, decoration: true,
                    parking: true, parking_valet: false, customer_space: true, buffet:)

      visit root_path
      click_on 'TMNT Buffet'
      click_on 'Festa infantil'

      expect(page).not_to have_content 'Editar Evento'
    end

    it 'trying by URL' do
      owner = Owner.create!(name: 'Splinter', email: 'splinter@email.com', password: 'password')

      buffet = Buffet.create!(brand_name: 'TMNT Buffet', payment: 'PIX', owner:)

      event = Event.create!(name: 'Festa infantil', description: 'Festa para crianças com temática TMNT', min_people: 10,
                    max_people: 100, duration: 300, menu: 'Pizza', alcoholic_beverages: false, decoration: true,
                    parking: true, parking_valet: false, customer_space: true, buffet:)

      visit edit_event_path event

      expect(current_path).not_to eq edit_event_path event
      expect(current_path).to eq new_owner_session_path
    end
  end

  context 'destroy' do
    it 'from homepage' do
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
  end
end
