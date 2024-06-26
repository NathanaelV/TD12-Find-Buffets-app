require 'rails_helper'

describe 'Owner sing in' do
  it 'successfully, but without Buffet registered' do
    Owner.create!(name: 'Leonardo', email: 'leonardo@email.com', password: 'password')

    visit root_path
    click_on 'Login para Dono de Buffet'
    within 'section#login' do
      fill_in 'E-mail',	with: 'leonardo@email.com'
      fill_in 'Senha', with: 'password'
      click_on 'Login'
    end

    within('nav') do
      expect(page).to have_content 'Leonardo <leonardo@email.com>'
      expect(page).to have_button 'Sair'
    end
    # expect(page).to have_content 'Login efetuado com sucesso'
    expect(page).not_to have_link 'Login'
    expect(page).to have_content 'Cadastrar Buffet'
  end

  it 'and logout' do
    owner = Owner.create!(name: 'Leonardo', email: 'leonardo@email.com', password: 'password')

    login_as owner, scope: :owner
    visit root_path
    click_on 'Sair'

    expect(page).to have_content 'Logout efetuado com sucesso.'
    expect(page).not_to have_button 'Sair'
    expect(page).not_to have_content 'Leonardo <leonardo@email.com>'
    within('nav') do
      expect(page).to have_link 'Login'
    end
  end

  it 'successfully with Buffet registered' do
    owner = Owner.create!(name: 'Leonardo', email: 'leonardo@email.com', password: 'password')
    Buffet.create!(brand_name: 'Teenage Mutant Ninja Turtles', corporate_name: 'TMNT Splinter LTDA',
                   registration_number: '88392017000182', phone: '11912341234',
                   email: 'contato@tmntsplinter.com', address: 'Rua Estados Unidos, 1030 - Jardins',
                   city: 'São Paulo', state: 'SP', zip_code: '01234123',
                   description: 'Melhor Buffet da região. Cowabunga', payment: 'PIX', owner:)

    login_as owner, scope: :owner
    visit root_path

    expect(page).not_to have_content 'Cadastrar Buffet'
    expect(page).to have_content 'Teenage Mutant Ninja Turtles'
  end
end
