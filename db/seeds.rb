# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
Owner.find_or_create_by!(name: 'Leonardo Yoshi', email: 'leonardo.yoshi@email.com', password: 'leonardo123')
Owner.find_or_create_by!(name: 'Casey Jones', email: 'casey.jones@email.com', password: 'casey.jones123')
Owner.find_or_create_by!(name: 'Donatello Yoshi', email: 'donatello.yoshi@email.com', password: 'donatello123')
