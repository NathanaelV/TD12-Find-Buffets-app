require 'rails_helper'

describe 'Buffet Owner view buffet details' do
  it 'successfully' do
    owner = Owner.create!(name: 'Splinter', email: 'splinter@email.com', password: 'password')
    Buffet.create!(brand_name: 'Teenage Mutant Ninja Turtles', corporate_name: 'TMNT Splinter LTDA',
                   registration_number: '88392017000182', phone: '11912341234',
                   email: 'contato@tmntsplinter.com', address: 'Rua Estados Unidos, 1030 - Jardins',
                   city: 'São Paulo', state: 'SP', zip_code: '01234123',
                   description: 'Melhor Buffet da região. Cowabunga', payment: 'PIX', owner:)

    login_as owner, scope: :owner
    visit root_path

    expect(page).to have_content 'Buffet Teenage Mutant Ninja Turtles'
    expect(page).to have_content 'Razão social: TMNT Splinter LTDA'
    expect(page).to have_content 'CNPJ: 88392017000182'
    expect(page).to have_content 'Telefone: 11912341234'
    expect(page).to have_content 'E-mail: contato@tmntsplinter.com'
    expect(page).to have_content 'Endereço: Rua Estados Unidos, 1030 - Jardins'
    expect(page).to have_content 'CEP: 01234123'
    expect(page).to have_content 'Cidade: São Paulo - SP'
    expect(page).to have_content 'Descrição: Melhor Buffet da região. Cowabunga'
    expect(page).to have_content 'Formas de pagamento: PIX'
    expect(page).to have_content 'Proprietário: Splinter'
  end

  it 'if it yours' do
    owner = Owner.create!(name: 'Splinter Yoshi', email: 'splinter@email.com', password: 'password')
    phoenix = Owner.create!(name: 'Phoenix Ikki', email: 'phoenix.ikki@saint.com', password: 'phoenix.ikki123')

    buffet = Buffet.create!(brand_name: 'Teenage Mutant Ninja Turtles', corporate_name: 'TMNT Splinter LTDA',
                            registration_number: '88392017000182', phone: '11912341234',
                            email: 'contato@tmntsplinter.com', address: 'Rua Estados Unidos, 1030 - Jardins',
                            city: 'São Paulo', state: 'SP', zip_code: '01234123',
                            description: 'Melhor Buffet da região. Cowabunga', payment: 'PIX', owner:)

    saint_seiya = Buffet.create!(brand_name: 'Os Cavaleiro dos Zodíacos', corporate_name: 'Saint Seiya LTDA',
                                 registration_number: '12192017000312', phone: '11905051212',
                                 email: 'contato@saintseiya.com', address: 'Estrada das 12 casas, 12 - Grécia',
                                 city: 'São Paulo', state: 'SP', zip_code: '01212005',
                                 description: 'Venha elevar o seu cosmo conosco.',
                                 payment: 'PIX, Cartão de Débito, Cartão de Crédito', owner: phoenix)

    login_as phoenix, scope: :owner
    visit buffet_path(buffet)

    expect(current_path).to eq buffet_path(saint_seiya)
  end
end
