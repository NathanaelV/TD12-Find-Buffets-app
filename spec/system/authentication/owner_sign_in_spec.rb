require 'rails_helper'

describe 'Buffet owner sing in' do
  it 'successfully, but without Buffet registered' do
    Owner.create!(name: 'Leonardo', email: 'leonardo@email.com', password: 'password')

    visit root_path
    click_on 'Login'
    within 'form' do
      fill_in 'E-mail',	with: 'leonardo@email.com'
      fill_in 'Senha', with: 'password'
      click_on 'Login'
    end

    within('nav') do
      expect(page).to have_content 'Leonardo <leonardo@email.com>'
      expect(page).to have_button 'Sair'
    end
    expect(page).to have_content 'Login efetuado com sucesso'
    expect(page).not_to have_link 'Login'
    expect(page).to have_content 'Cadastrar Buffet'
  end

  it 'and logout' do
    Owner.create!(name: 'Leonardo', email: 'leonardo@email.com', password: 'password')

    visit root_path
    click_on 'Login'
    within 'form' do
      fill_in 'E-mail',	with: 'leonardo@email.com'
      fill_in 'Senha', with: 'password'
      click_on 'Login'
    end
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
    payment = Payment.create!(name: 'PIX')
    Buffet.create!(brand_name: 'TMNT Buffet', corporate_name: 'TMNT Splinter LTDA',
                   registration_number: '88392017000182', phone: '11912341234',
                   email: 'contato@tmntsplinter.com', address: 'Rua Estados Unidos, 1030 - Jardins',
                   city: 'São Paulo', state: 'SP', zip_code: '01234123',
                   description: 'Melhor Buffet da região. Cowabunga', payment:, owner:)

    visit root_path
    click_on 'Login'
    within 'form' do
      fill_in 'E-mail',	with: 'leonardo@email.com'
      fill_in 'Senha', with: 'password'
      click_on 'Login'
    end

    expect(page).not_to have_content 'Cadastrar Buffet'
    expect(page).to have_content 'TMNT Buffet'
  end
end
