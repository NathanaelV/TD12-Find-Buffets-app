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
                     description: 'Melhor Buffet da região. Cowabunga', payment: 'PIX, Catão de Débito',
                     owner:)

      second_buffet = Buffet.create!(brand_name: 'Os Cavaleiro dos Zodíacos', corporate_name: 'Saint Seiya LTDA',
                     registration_number: '12192017000312', phone: '11905051212', email: 'contato@saintseiya.com',
                     address: 'Estrada das 12 casas, 12 - Grécia', city: 'São Paulo', state: 'SP', zip_code: '01212005',
                     description: 'Venha elevar o seu cosmo conosco.',
                     payment: 'PIX, Catão de Débito, Cartão de Crédito', owner: phoenix)

      get "/api/v1/buffets"

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq 2
      expect(response.body).to include first_buffet.to_json(except: %i[created_at updated_at])
      expect(response.body).to include second_buffet.to_json(except: %i[created_at updated_at])
    end

    it 'return empty if there is no Buffets' do
      get "/api/v1/buffets"

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      expect(response.body).to eq [].to_json
    end

    it 'and raise iternal error' do
      allow(Buffet).to receive(:all).and_raise(ActiveRecord::QueryCanceled)

      get '/api/v1/buffets'

      expect(response).to have_http_status(500)
    end
  end
end
