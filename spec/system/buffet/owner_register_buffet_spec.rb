require 'rails_helper'

describe 'Owner regiters buffet' do
  it 'if is register' do
    visit new_buffet_path

    expect(current_path).to eq new_owner_session_path
  end

  it 'successfully' do
    owner = Owner.create!(name: 'Splinter', email: 'splinter@email.com', password: 'password')

    login_as owner, scope: :owner
    visit root_path
    fill_in 'Nome fantasia', with: 'Teenage Mutant Ninja Turtles'
    fill_in 'Razão social', with: 'TMNT Splinter LTDA'
    fill_in 'CNPJ', with: '88392017000182'
    fill_in 'Telefone', with: '11912341234'
    fill_in 'E-mail', with: 'contato@tmntsplinter.com'
    fill_in 'Endereço', with: 'Rua Estados Unidos, 1030 - Jardins'
    fill_in 'Cidade', with: 'São Paulo'
    fill_in 'Estado', with: 'SP'
    fill_in 'CEP', with: '01234123'
    fill_in 'Descrição', with: 'Melhor Buffet da região. Cowabunga'
    fill_in 'Formas de pagamento', with: 'PIX, Cartão de Débito'
    click_on 'Criar Buffet'

    expect(page).to have_content 'Buffet criado com sucesso!'
    expect(page).to have_content 'Buffet Teenage Mutant Ninja Turtles'
    expect(page).to have_content 'Razão social: TMNT Splinter LTDA'
    expect(page).to have_content 'CNPJ: 88392017000182'
    expect(page).to have_content 'Telefone: 11912341234'
    expect(page).to have_content 'E-mail: contato@tmntsplinter.com'
    expect(page).to have_content 'Endereço: Rua Estados Unidos, 1030 - Jardins'
    expect(page).to have_content 'CEP: 01234123'
    expect(page).to have_content 'Cidade: São Paulo - SP'
    expect(page).to have_content 'Descrição: Melhor Buffet da região. Cowabunga'
    expect(page).to have_content 'Proprietário: Splinter'
    expect(page).to have_content 'Formas de pagamento: PIX, Cartão de Débito'
  end
end
