# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
Owner.find_or_create_by!(name: 'Leonardo Yoshi', email: 'leonardo.yoshi@email.com',
                               encrypted_password: 'leonardo123')
Owner.find_or_create_by!(name: 'Splinter Yoshi', email: 'splinter.yoshi@email.com',
                               encrypted_password: 'splinter123')

# Buffet
Buffet.find_or_create_by!(brand_name: 'Teenage Mutant Ninja Turtles', corporate_name: 'TMNT Splinter LTDA',
                          registration_number: '88392017000182', phone: '11912341234',
                          email: 'contato@tmntsplinter.com', address: 'Rua Estados Unidos, 1030 - Jardins',
                          city: 'São Paulo', state: 'SP', zip_code: '01234123',
                          description: 'Melhor Buffet da região. Cowabunga', payment_id: Payment.first.id,
                          buffet_owner_id: BuffetOwner.first.id)

# Event
Event.find_or_create_by!(name: 'Festa infantil', description: 'Festa para crianças com temática TMNT',
                         min_people: 10, max_people: 100, duration: 300, menu: 'Pizza', alcoholic_beverages: true,
                         decoration: true, parking: true, parking_valet: true, customer_space: true,
                         buffet_id: Buffet.first.id)
