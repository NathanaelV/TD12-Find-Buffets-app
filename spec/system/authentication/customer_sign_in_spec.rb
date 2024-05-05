require 'rails_helper'

describe 'Customer sing in' do
  it 'successfully' do
    Customer.create!(name: 'Donatello Hamato', cpf: '599.622.000-83', email: 'donatello@email.com',
                     password: 'donatello123')

    owner = Owner.create!(name: 'Leonardo', email: 'leonardo@email.com', password: 'password')
    Buffet.create!(brand_name: 'TMNT Buffet', corporate_name: 'TMNT Splinter LTDA',
                   registration_number: '88392017000182', phone: '11912341234',
                   email: 'contato@tmntsplinter.com', address: 'Rua Estados Unidos, 1030 - Jardins',
                   city: 'São Paulo', state: 'SP', zip_code: '01234123',
                   description: 'Melhor Buffet da região. Cowabunga', payment: 'PIX', owner:)

    visit root_path
    click_on 'Login para Clientes'
    within 'section#login' do
      fill_in 'E-mail',	with: 'donatello@email.com'
      fill_in 'Senha', with: 'donatello123'
      click_on 'Login'
    end

    within('nav') do
      expect(page).to have_content 'Donatello Hamato <donatello@email.com>'
      expect(page).to have_button 'Sair'
    end
    expect(page).to have_content 'Login efetuado com sucesso'
    expect(page).to have_content 'TMNT Buffet'
    expect(page).not_to have_link 'Login'
  end

  it 'and logout' do
    customer = Customer.create!(name: 'Donatello Hamato', cpf: '599.622.000-83', email: 'donatello@email.com',
                                password: 'donatello123')

    login_as(customer)
    visit root_path
    click_on 'Sair'

    expect(page).to have_content 'Logout efetuado com sucesso.'
    expect(page).not_to have_button 'Sair'
    expect(page).not_to have_content 'Donatello Hamato <donatello@email.com>'
    within('nav') do
      expect(page).to have_link 'Login'
    end
  end
end
