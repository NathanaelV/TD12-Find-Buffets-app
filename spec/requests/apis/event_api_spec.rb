require 'rails_helper'

describe 'Events API' do
  context 'GET /api/v1/:buffet_id/events' do
    it 'successfully' do
      owner = Owner.create!(name: 'Leonardo Yoshi', email: 'leonardo.yoshi@email.com', password: 'leonardo123')
      phoenix = Owner.create!(name: 'Phoenix Ikki', email: 'phoenix.ikki@saint.com', password: 'phoenix.ikki123')

      buffet = Buffet.create!(brand_name: 'Teenage Mutant Ninja Turtles', corporate_name: 'TMNT Splinter LTDA',
                              registration_number: '88392017000182', phone: '11912341234',
                              email: 'contato@tmntsplinter.com', address: 'Rua Estados Unidos, 1030 - Jardins',
                              city: 'São Paulo', state: 'SP', zip_code: '01234123',
                              description: 'Melhor Buffet da região. Cowabunga', payment: 'PIX, Cartão de Débito',
                              owner:)

      second_buffet = Buffet.create!(brand_name: 'Os Cavaleiro dos Zodíacos', corporate_name: 'Saint Seiya LTDA',
                                     registration_number: '12192017000312', phone: '11905051212',
                                     email: 'contato@saintseiya.com', address: 'Estrada das 12 casas, 12 - Grécia',
                                     city: 'São Paulo', state: 'SP', zip_code: '01212005',
                                     description: 'Venha elevar o seu cosmo conosco.',
                                     payment: 'PIX, Cartão de Débito, Cartão de Crédito', owner: phoenix)

      Event.create!(name: 'Festa infantil', description: 'Festa para crianças com temática TMNT', min_people: 10,
                    max_people: 100, duration: 300, menu: 'Pizza',
                    alcoholic_beverages: false, decoration: true, parking: true, parking_valet: false,
                    customer_space: true, buffet:)

      Event.create!(name: 'Coffee Break', description: 'Coffee Break para crianças grandes', min_people: 20,
                    max_people: 120, duration: 240, menu: 'Pizza e café', alcoholic_beverages: true, decoration: true,
                    parking: true, parking_valet: true, customer_space: true, buffet: second_buffet)

      Event.create!(name: 'Festa de casamento', description: 'Festa de casamento dos sonhos', min_people: 10,
                    max_people: 100, duration: 420, menu: 'Pizza', alcoholic_beverages: true, decoration: true,
                    parking: true, parking_valet: true, customer_space: true, buffet:)

      get "/api/v1/buffets/#{buffet.id}/events"

      expect(response).to have_http_status 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq 2
      expect(json_response.first['id']).to eq 1
      expect(json_response.first['name']).to eq 'Festa infantil'
      expect(json_response.first['description']).to eq 'Festa para crianças com temática TMNT'
      expect(json_response.first['min_people']).to eq 10
      expect(json_response.first['max_people']).to eq 100
      expect(json_response.first['duration']).to eq 300
      expect(json_response.first['menu']).to eq 'Pizza'
      expect(json_response.first['alcoholic_beverages']).to eq false
      expect(json_response.first['decoration']).to eq true
      expect(json_response.first['parking']).to eq true
      expect(json_response.first['parking_valet']).to eq false
      expect(json_response.first['customer_space']).to eq true
      expect(json_response.first['buffet']['id']).to eq 1
      expect(json_response.first['buffet']['brand_name']).to eq 'Teenage Mutant Ninja Turtles'

      expect(json_response.first).not_to have_key 'buffet_id'
      expect(json_response.first).not_to have_key 'created_at'
      expect(json_response.first).not_to have_key 'updated_at'

      expect(json_response.second['id']).to eq 3
      expect(json_response.second['name']).to eq 'Festa de casamento'
      expect(json_response.second['description']).to eq 'Festa de casamento dos sonhos'
      expect(json_response.second['min_people']).to eq 10
      expect(json_response.second['max_people']).to eq 100
      expect(json_response.second['duration']).to eq 420
      expect(json_response.second['menu']).to eq 'Pizza'
      expect(json_response.second['alcoholic_beverages']).to eq true
      expect(json_response.second['decoration']).to eq true
      expect(json_response.second['parking']).to eq true
      expect(json_response.second['parking_valet']).to eq true
      expect(json_response.second['customer_space']).to eq true
      expect(json_response.second['buffet']['id']).to eq 1
      expect(json_response.second['buffet']['brand_name']).to eq 'Teenage Mutant Ninja Turtles'

      expect(json_response.second).not_to have_key 'buffet_id'
      expect(json_response.second).not_to have_key 'created_at'
      expect(json_response.second).not_to have_key 'updated_at'
    end

    it 'there is no event' do
      owner = Owner.create!(name: 'Leonardo Yoshi', email: 'leonardo.yoshi@email.com', password: 'leonardo123')

      buffet = Buffet.create!(brand_name: 'Teenage Mutant Ninja Turtles', corporate_name: 'TMNT Splinter LTDA',
                              registration_number: '88392017000182', phone: '11912341234',
                              email: 'contato@tmntsplinter.com', address: 'Rua Estados Unidos, 1030 - Jardins',
                              city: 'São Paulo', state: 'SP', zip_code: '01234123',
                              description: 'Melhor Buffet da região. Cowabunga', payment: 'PIX, Cartão de Débito',
                              owner:)

      get "/api/v1/buffets/#{buffet.id}/events"

      expect(response).to have_http_status 200
      expect(response.content_type).to include 'application/json'
      expect(response.body).to eq [].to_json
    end

    it 'there is no buffet' do
      owner = Owner.create!(name: 'Leonardo Yoshi', email: 'leonardo.yoshi@email.com', password: 'leonardo123')

      Buffet.create!(brand_name: 'Teenage Mutant Ninja Turtles', corporate_name: 'TMNT Splinter LTDA',
                     registration_number: '88392017000182', phone: '11912341234',
                     email: 'contato@tmntsplinter.com', address: 'Rua Estados Unidos, 1030 - Jardins',
                     city: 'São Paulo', state: 'SP', zip_code: '01234123',
                     description: 'Melhor Buffet da região. Cowabunga', payment: 'PIX, Cartão de Débito',
                     owner:)

      get '/api/v1/buffets/404/events'

      expect(response).to have_http_status 404
      expect(response.content_type).to include 'application/json'
      expect(response.body).to include 'Buffet não encontrado. Verifique o ID'
    end
  end
end
