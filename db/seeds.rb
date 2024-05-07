# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Owner
leo_yoshi = Owner.create!(name: 'Leonardo Yoshi', email: 'leonardo.yoshi@email.com', password: 'leonardo123')
Owner.create!(name: 'Casey Jones', email: 'casey.jones@email.com', password: 'casey.jones123')
phoenix = Owner.create!(name: 'Phoenix Ikki', email: 'phoenix.ikki@saint.com', password: 'phoenix.ikki123')

# Customer
customer = Customer.create!(name: 'Donatello Hamato', cpf: '599.622.000-83', email: 'donatello@email.com',
                            password: 'donatello123')
Customer.create!(name: 'Dragon Shiryu', cpf: '665.455.630-50', email: 'shiryu@email.com', password: 'shiryu123')

# Buffet
buffet = Buffet.find_or_create_by!(brand_name: 'Teenage Mutant Ninja Turtles', corporate_name: 'TMNT Splinter LTDA',
                                   registration_number: '88392017000182', phone: '11912341234',
                                   email: 'contato@tmntsplinter.com', address: 'Rua Estados Unidos, 1030 - Jardins',
                                   city: 'São Paulo', state: 'SP', zip_code: '01234123',
                                   description: 'Melhor Buffet da região. Cowabunga', payment: 'PIX, Catão de Débito',
                                   owner: leo_yoshi)

Buffet.find_or_create_by!(brand_name: 'Os Cavaleiro dos Zodíacos', corporate_name: 'Saint Seiya LTDA',
                          registration_number: '12192017000312', phone: '11905051212',
                          email: 'contato@saintseiya.com', address: 'Estrada das 12 casas, 12 - Grécia',
                          city: 'São Paulo', state: 'SP', zip_code: '01212005',
                          description: 'Venha elevar o seu cosmo conosco.',
                          payment: 'PIX, Catão de Débito, Cartão de Crédito', owner: phoenix)

# Event
event = Event.find_or_create_by!(name: 'Festa infantil', description: 'Festa para crianças com temática TMNT',
                                 min_people: 10, max_people: 100, duration: 300, menu: 'Pizza',
                                 alcoholic_beverages: false, decoration: true, parking: true, parking_valet: false,
                                 customer_space: true, buffet:)

Event.find_or_create_by!(name: 'Festa de casamento', description: 'Festa de casamento dos sonhos', min_people: 10,
                         max_people: 100, duration: 420, menu: 'Pizza', alcoholic_beverages: true, decoration: true,
                         parking: true, parking_valet: true, customer_space: true, buffet:)

# Event Cost
EventCost.create!(description: 'Dias de semana', minimum: 200_000, additional_per_person: 7_000, overtime: 10_0000,
event:)
EventCost.create!(description: 'Fim de semana', minimum: 400_000, additional_per_person: 14_000, overtime: 20_0000,
event:)

Order.create!(event_date: 2.month.from_now.strftime('%d/%m/%Y'), people: 80, details: 'Dia especial',
              address: 'Sítio do Barnabé', buffet:, customer:, event:)
Order.create!(event_date: 3.month.from_now.strftime('%d/%m/%Y'), people: 80, details: 'Dia especial',
              address: 'No Próprio Buffet', buffet:, customer:, event:, status: :approved)
