require 'rails_helper'

describe 'Customer sign up' do
  it 'successfully' do
    visit root_path
    click_on 'Login para Clientes'
    click_on 'Criar uma conta'
    within 'section#registration' do
      fill_in 'Nome',	with: 'Donatello Hamato'
      fill_in 'CPF',	with: '599.622.000-83'
      fill_in 'E-mail',	with: 'donatello@email.com'
      fill_in 'Senha', with: 'password'
      fill_in 'Confirme sua senha', with: 'password'
      click_on 'Criar Cliente'
    end

    expect(page).to have_content 'Boas vindas! Você realizou seu registro com sucesso.'
    expect(page).to have_content 'Donatello Hamato <donatello@email.com>'
    expect(page).to have_content 'Nenhum Buffet cadastrado'
    expect(page).not_to have_link 'Login'
  end
end
