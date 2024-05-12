require 'rails_helper'

describe 'Order API' do
  context 'POST /api/v1/events/:event_id/orders' do
    it 'successfully' do
      owner = Owner.create!(name: 'Leonardo Yoshi', email: 'leonardo.yoshi@email.com', password: 'leonardo123')

      buffet = Buffet.create!(brand_name: 'Teenage Mutant Ninja Turtles', corporate_name: 'TMNT Splinter LTDA',
                              registration_number: '88392017000182', phone: '11912341234',
                              email: 'contato@tmntsplinter.com', address: 'Rua Estados Unidos, 1030 - Jardins',
                              city: 'São Paulo', state: 'SP', zip_code: '01234123',
                              description: 'Melhor Buffet da região. Cowabunga', payment: 'PIX, Cartão de Débito',
                              owner:)

      event = Event.create!(name: 'Festa infantil', description: 'Festa para crianças com temática TMNT',
                            min_people: 10, max_people: 100, duration: 300, menu: 'Pizza', alcoholic_beverages: false,
                            decoration: true, parking: true, parking_valet: false, customer_space: true, buffet:)

      EventCost.create!(description: 'Fim de semana', minimum: 400_000, additional_per_person: 14_000,
                        overtime: 200_000, event:)

      event_date = 4.day.from_now.strftime('%d/%m/%Y')
      order_params = { order: { event_date:, people: 80 } }

      post "/api/v1/buffets/#{buffet.id}/events/#{event.id}/orders", params: order_params

      expect(response).to have_http_status 201
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response['advance_price']).to eq 'R$ 13800.00'
    end

    it 'params are not complete' do
      owner = Owner.create!(name: 'Leonardo Yoshi', email: 'leonardo.yoshi@email.com', password: 'leonardo123')

      buffet = Buffet.create!(brand_name: 'Teenage Mutant Ninja Turtles', corporate_name: 'TMNT Splinter LTDA',
                              registration_number: '88392017000182', phone: '11912341234',
                              email: 'contato@tmntsplinter.com', address: 'Rua Estados Unidos, 1030 - Jardins',
                              city: 'São Paulo', state: 'SP', zip_code: '01234123',
                              description: 'Melhor Buffet da região. Cowabunga', payment: 'PIX, Cartão de Débito',
                              owner:)

      event = Event.create!(name: 'Festa infantil', description: 'Festa para crianças com temática TMNT',
                            min_people: 10, max_people: 100, duration: 300, menu: 'Pizza', alcoholic_beverages: false,
                            decoration: true, parking: true, parking_valet: false, customer_space: true, buffet:)

      EventCost.create!(description: 'Fim de semana', minimum: 400_000, additional_per_person: 14_000,
                        overtime: 200_000, event:)

      order_params = { order: { event_date: nil, people: nil } }

      post "/api/v1/buffets/#{buffet.id}/events/#{event.id}/orders", params: order_params

      expect(response).to have_http_status 412
      expect(response.body).to include 'Data do evento não pode ficar em branco'
      expect(response.body).to include 'Quantidade de pessoas não pode ficar em branco'
      expect(response.body).not_to include 'Buffet é obrigatório'
      expect(response.body).not_to include 'Cliente é obrigatório'
    end

    it 'order cannot be blank' do
      owner = Owner.create!(name: 'Leonardo Yoshi', email: 'leonardo.yoshi@email.com', password: 'leonardo123')

      buffet = Buffet.create!(brand_name: 'Teenage Mutant Ninja Turtles', corporate_name: 'TMNT Splinter LTDA',
                              registration_number: '88392017000182', phone: '11912341234',
                              email: 'contato@tmntsplinter.com', address: 'Rua Estados Unidos, 1030 - Jardins',
                              city: 'São Paulo', state: 'SP', zip_code: '01234123',
                              description: 'Melhor Buffet da região. Cowabunga', payment: 'PIX, Cartão de Débito',
                              owner:)

      event = Event.create!(name: 'Festa infantil', description: 'Festa para crianças com temática TMNT',
                            min_people: 10, max_people: 100, duration: 300, menu: 'Pizza', alcoholic_beverages: false,
                            decoration: true, parking: true, parking_valet: false, customer_space: true, buffet:)

      post "/api/v1/buffets/#{buffet.id}/events/#{event.id}/orders", params: {}

      expect(response).to have_http_status 412
      expect(response.body).to include 'Order não pode ficar em branco'
    end

    it 'busy date' do
      owner = Owner.create!(name: 'Leonardo Yoshi', email: 'leonardo.yoshi@email.com', password: 'leonardo123')

      buffet = Buffet.create!(brand_name: 'Teenage Mutant Ninja Turtles', corporate_name: 'TMNT Splinter LTDA',
                              registration_number: '88392017000182', phone: '11912341234',
                              email: 'contato@tmntsplinter.com', address: 'Rua Estados Unidos, 1030 - Jardins',
                              city: 'São Paulo', state: 'SP', zip_code: '01234123',
                              description: 'Melhor Buffet da região. Cowabunga', payment: 'PIX, Cartão de Débito',
                              owner:)

      event = Event.create!(name: 'Festa infantil', description: 'Festa para crianças com temática TMNT',
                            min_people: 10, max_people: 100, duration: 300, menu: 'Pizza', alcoholic_beverages: false,
                            decoration: true, parking: true, parking_valet: false, customer_space: true, buffet:)

      EventCost.create!(description: 'Fim de semana', minimum: 400_000, additional_per_person: 14_000,
                        overtime: 200_000, event:)

      customer = Customer.create!(name: 'Donatello Hamato', cpf: '599.622.000-83', email: 'donatello@email.com',
                                  password: 'donatello123')

      event_date = 3.month.from_now.strftime('%d/%m/%Y')
      Order.create!(event_date:, people: 80, details: 'Dia especial', address: 'No Próprio Buffet', buffet:, customer:,
                    event:, status: :approved)

      order_params = { order: { event_date:, people: 80 } }
      post "/api/v1/buffets/#{buffet.id}/events/#{event.id}/orders", params: order_params

      expect(response).to have_http_status 412
      expect(response.body).to include 'Buffet indisponível na data escolhida'
    end
  end
end
