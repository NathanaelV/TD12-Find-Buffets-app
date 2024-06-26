require 'rails_helper'

describe 'Customer view buffet details' do
  it 'successfully' do
    customer = Customer.create!(name: 'Dragon Shiryu', cpf: '665.455.630-50', email: 'shiryu@email.com',
                                password: 'shiryu123')

    owner = Owner.create!(name: 'Splinter', email: 'splinter@email.com', password: 'password')
    Buffet.create!(brand_name: 'Teenage Mutant Ninja Turtles', corporate_name: 'TMNT Splinter LTDA',
                   registration_number: '88392017000182', phone: '11912341234',
                   email: 'contato@tmntsplinter.com', address: 'Rua Estados Unidos, 1030 - Jardins',
                   city: 'São Paulo', state: 'SP', zip_code: '01234123',
                   description: 'Melhor Buffet da região. Cowabunga', payment: 'PIX', owner:)

    login_as customer, scope: :customer
    visit root_path
    click_on 'Teenage Mutant Ninja Turtles'

    expect(page).to have_content 'Buffet Teenage Mutant Ninja Turtles'
    expect(page).not_to have_content 'Razão social: TMNT Splinter LTDA'
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
end
