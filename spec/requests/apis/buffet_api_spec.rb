require 'rails_helper'

describe 'Buffet API' do
  context 'GET /api/v1/buffets' do
    it 'successfully' do
      owner = Owner.create!(name: 'Leonardo Yoshi', email: 'leonardo.yoshi@email.com', password: 'leonardo123')
      phoenix = Owner.create!(name: 'Phoenix Ikki', email: 'phoenix.ikki@saint.com', password: 'phoenix.ikki123')

      first_buffet = Buffet.create!(brand_name: 'Teenage Mutant Ninja Turtles', corporate_name: 'TMNT Splinter LTDA',
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

      get '/api/v1/buffets'

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq 2
      expect(json_response.first['id']).to eq first_buffet.id
      expect(json_response.first['brand_name']).to eq 'Teenage Mutant Ninja Turtles'
      expect(json_response.first['city']).to eq 'São Paulo'
      expect(json_response.first['state']).to eq 'SP'
      expect(json_response.first).not_to have_key 'corporate_name'
      expect(json_response.first).not_to have_key 'registration_number'
      expect(json_response.first).not_to have_key 'phone'
      expect(json_response.first).not_to have_key 'email'
      expect(json_response.first).not_to have_key 'address'
      expect(json_response.first).not_to have_key 'zip_code'
      expect(json_response.first).not_to have_key 'description'
      expect(json_response.first).not_to have_key 'payment'
      expect(json_response.first).not_to have_key 'owner_id'
      expect(json_response.first).not_to have_key 'created_at'
      expect(json_response.first).not_to have_key 'updated_at'

      expect(json_response.second['id']).to eq second_buffet.id
      expect(json_response.second['brand_name']).to eq 'Os Cavaleiro dos Zodíacos'
      expect(json_response.second['city']).to eq 'São Paulo'
      expect(json_response.second['state']).to eq 'SP'
      expect(json_response.second).not_to have_key 'corporate_name'
      expect(json_response.second).not_to have_key 'registration_number'
      expect(json_response.second).not_to have_key 'phone'
      expect(json_response.second).not_to have_key 'email'
      expect(json_response.second).not_to have_key 'address'
      expect(json_response.second).not_to have_key 'zip_code'
      expect(json_response.second).not_to have_key 'description'
      expect(json_response.second).not_to have_key 'payment'
      expect(json_response.second).not_to have_key 'owner_id'
      expect(json_response.second).not_to have_key 'created_at'
      expect(json_response.second).not_to have_key 'updated_at'
    end

    it 'return empty if there is no Buffets' do
      get '/api/v1/buffets'

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      expect(response.body).to eq [].to_json
    end

    it 'and raise iternal error' do
      allow(Buffet).to receive(:all).and_raise(ActiveRecord::QueryCanceled)

      get '/api/v1/buffets'

      expect(response).to have_http_status(500)
    end

    it 'using a query' do
      owner = Owner.create!(name: 'Leonardo Yoshi', email: 'leonardo.yoshi@email.com', password: 'leonardo123')
      phoenix = Owner.create!(name: 'Phoenix Ikki', email: 'phoenix.ikki@saint.com', password: 'phoenix.ikki123')
      batman = Owner.create!(name: 'Bruce Wayne', email: 'bruce.wayne@dccomix.com', password: 'nanananana_batman!')

      first_buffet = Buffet.create!(brand_name: 'Teenage Mutant Ninja Turtles', corporate_name: 'TMNT Splinter LTDA',
                                    registration_number: '88392017000182', phone: '11912341234',
                                    email: 'contato@tmntsplinter.com', address: 'Rua Estados Unidos, 1030 - Jardins',
                                    city: 'São Paulo', state: 'SP', zip_code: '01234123',
                                    description: 'Melhor Buffet da região. Cowabunga', payment: 'PIX, Cartão de Débito',
                                    owner:)

      Buffet.create!(brand_name: 'Os Cavaleiro dos Zodíacos', corporate_name: 'Saint Seiya LTDA',
                     registration_number: '12192017000312', phone: '11905051212', email: 'contato@saintseiya.com',
                     address: 'Estrada das 12 casas, 12 - Grécia', city: 'São Paulo', state: 'SP', zip_code: '01212005',
                     description: 'Venha elevar o seu cosmo conosco.',
                     payment: 'PIX, Cartão de Débito, Cartão de Crédito', owner: phoenix)

      second_buffet = Buffet.create!(brand_name: 'Teen Titans', corporate_name: 'Justice League Teens',
                                     registration_number: '70849145000147', phone: '11900001111',
                                     email: 'contato@teentitans.com', address: 'Torre T, s/n - Ilha',
                                     city: 'Florianópolis', state: 'SC', zip_code: '88000-123',
                                     description: 'Batman é o melhor.',
                                     payment: 'PIX, Cartão de Débito, Cartão de Crédito', owner: batman)

      get '/api/v1/buffets', params: { buffet_name: 'teen' }

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq 2
      expect(json_response.first['id']).to eq first_buffet.id
      expect(json_response.first['brand_name']).to eq 'Teenage Mutant Ninja Turtles'
      expect(json_response.second['id']).to eq second_buffet.id
      expect(json_response.second['brand_name']).to eq 'Teen Titans'
    end
  end

  context 'GET /api/v1/buffets/:id' do
    it 'successfully' do
      owner = Owner.create!(name: 'Leonardo Yoshi', email: 'leonardo.yoshi@email.com', password: 'leonardo123')
      phoenix = Owner.create!(name: 'Phoenix Ikki', email: 'phoenix.ikki@saint.com', password: 'phoenix.ikki123')

      first_buffet = Buffet.create!(brand_name: 'Teenage Mutant Ninja Turtles', corporate_name: 'TMNT Splinter LTDA',
                                    registration_number: '88392017000182', phone: '11912341234',
                                    email: 'contato@tmntsplinter.com', address: 'Rua Estados Unidos, 1030 - Jardins',
                                    city: 'São Paulo', state: 'SP', zip_code: '01234123',
                                    description: 'Melhor Buffet da região. Cowabunga', payment: 'PIX, Cartão de Débito',
                                    owner:)

      Buffet.create!(brand_name: 'Os Cavaleiro dos Zodíacos', corporate_name: 'Saint Seiya LTDA',
                     registration_number: '12192017000312', phone: '11905051212',
                     email: 'contato@saintseiya.com', address: 'Estrada das 12 casas, 12 - Grécia',
                     city: 'São Paulo', state: 'SP', zip_code: '01212005',
                     description: 'Venha elevar o seu cosmo conosco.',
                     payment: 'PIX, Cartão de Débito, Cartão de Crédito', owner: phoenix)

      get "/api/v1/buffets/#{first_buffet.id}"

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response['id']).to eq first_buffet.id
      expect(json_response['brand_name']).to eq 'Teenage Mutant Ninja Turtles'
      expect(json_response['phone']).to eq '11912341234'
      expect(json_response['email']).to eq 'contato@tmntsplinter.com'
      expect(json_response['address']).to eq 'Rua Estados Unidos, 1030 - Jardins'
      expect(json_response['city']).to eq 'São Paulo'
      expect(json_response['state']).to eq 'SP'
      expect(json_response['zip_code']).to eq '01234123'
      expect(json_response['description']).to eq 'Melhor Buffet da região. Cowabunga'
      expect(json_response['payment']).to eq 'PIX, Cartão de Débito'
      expect(json_response).not_to have_key 'corporate_name'
      expect(json_response).not_to have_key 'registration_number'
      expect(json_response).not_to have_key 'owner_id'
      expect(json_response).not_to have_key 'owner'
      expect(json_response).not_to have_key 'created_at'
      expect(json_response).not_to have_key 'updated_at'
      expect(json_response).not_to include 'Os Cavaleiro dos Zodíacos'
    end

    it 'there is no Buffet' do
      get "/api/v1/buffets/999"

      expect(response.status).to eq 404
    end

    it 'and raise iternal error' do
      allow(Buffet).to receive(:find).and_raise(ActiveRecord::QueryCanceled)

      get '/api/v1/buffets/1'

      expect(response).to have_http_status(500)
    end
  end
end
