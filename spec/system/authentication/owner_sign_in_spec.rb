require 'rails_helper'

describe 'Owner sing in' do
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
    # expect(page).to have_content 'Login efetuado com sucesso'
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
end
