require 'rails_helper'

describe 'Visitor authorization for events' do
  context 'show' do
    it 'from homepage' do
      owner = Owner.create!(name: 'Donatello Yoshi', email: 'donatello.yoshi@email.com', password: 'donatello123')

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

      Buffet.create!(brand_name: 'Teenage Mutant Ninja Turtles', corporate_name: 'TMNT Splinter LTDA',
                     registration_number: '88392017000182', phone: '11912341234',
                     email: 'contato@tmntsplinter.com', address: 'Rua Estados Unidos, 1030 - Jardins',
                     city: 'São Paulo', state: 'SP', zip_code: '01234123',
                     description: 'Melhor Buffet da região. Cowabunga', payment: 'PIX, Cartão de Débito', owner:)

      visit root_path
      click_on 'Teenage Mutant Ninja Turtles'

      expect(page).not_to have_content 'Criar Evento'
    end

    it 'trying by URL' do
      owner = Owner.create!(name: 'Splinter', email: 'splinter@email.com', password: 'password')

      Buffet.create!(brand_name: 'Teenage Mutant Ninja Turtles', corporate_name: 'TMNT Splinter LTDA',
                     registration_number: '88392017000182', phone: '11912341234',
                     email: 'contato@tmntsplinter.com', address: 'Rua Estados Unidos, 1030 - Jardins',
                     city: 'São Paulo', state: 'SP', zip_code: '01234123',
                     description: 'Melhor Buffet da região. Cowabunga', payment: 'PIX, Cartão de Débito', owner:)

      visit new_event_path

      expect(current_path).not_to eq new_event_path
      expect(current_path).to eq new_owner_session_path
    end
  end

  context 'visitor cannot edit event' do
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

      visit root_path
      click_on 'Teenage Mutant Ninja Turtles'
      click_on 'Festa infantil'

      expect(page).not_to have_content 'Editar Evento'
    end

    it 'trying by URL' do
      owner = Owner.create!(name: 'Splinter', email: 'splinter@email.com', password: 'password')

      buffet = Buffet.create!(brand_name: 'Teenage Mutant Ninja Turtles', corporate_name: 'TMNT Splinter LTDA',
                              registration_number: '88392017000182', phone: '11912341234',
                              email: 'contato@tmntsplinter.com', address: 'Rua Estados Unidos, 1030 - Jardins',
                              city: 'São Paulo', state: 'SP', zip_code: '01234123',
                              description: 'Melhor Buffet da região. Cowabunga', payment: 'PIX, Cartão de Débito', owner:)

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

      expect(page).not_to have_content 'Excluir Evento'
    end
  end
end
