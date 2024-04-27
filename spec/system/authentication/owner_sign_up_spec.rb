require 'rails_helper'

describe 'Buffet owner sign up' do
  it 'successfully' do
    visit root_path
    click_on 'Login'
    click_on 'Criar uma conta'
    within 'form' do
      fill_in 'Nome',	with: 'Leonardo'
      fill_in 'E-mail',	with: 'leonardo@email.com'
      fill_in 'Senha', with: 'password'
      fill_in 'Confirme sua senha', with: 'password'
      click_on 'Criar Proprietário'
    end

    expect(page).to have_content 'Boas vindas! Você realizou seu registro com sucesso.'
    expect(page).not_to have_link 'Login'
  end
end
