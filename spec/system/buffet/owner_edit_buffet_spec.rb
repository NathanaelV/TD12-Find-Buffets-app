require 'rails_helper'

describe 'Buffet owner edit Buffet' do
  it 'view form' do
    owner = Owner.create!(name: 'Splinter Yoshi', email: 'splinter@email.com', password: 'password')
    Buffet.create!(brand_name: 'Teenage Mutant Ninja Turtles', corporate_name: 'TMNT Splinter LTDA',
                   registration_number: '88392017000182', phone: '11912341234',
                   email: 'contato@tmntsplinter.com', address: 'Rua Estados Unidos, 1030 - Jardins',
                   city: 'São Paulo', state: 'SP', zip_code: '01234123',
                   description: 'Melhor Buffet da região. Cowabunga', payment: 'PIX', owner:)

    login_as owner, scope: :owner
    visit root_path
    click_on 'Teenage Mutant Ninja Turtles'
    click_on 'Editar Buffet'

    expect(page).to have_content 'Editar Teenage Mutant Ninja Turtles'
    expect(page).to have_field 'Nome fantasia', with: 'Teenage Mutant Ninja Turtles'
    expect(page).to have_field 'Razão social', with: 'TMNT Splinter LTDA'
    expect(page).to have_field 'CNPJ', with: '88392017000182'
    expect(page).to have_field 'Telefone', with: '11912341234'
    expect(page).to have_field 'E-mail', with: 'contato@tmntsplinter.com'
    expect(page).to have_field 'Endereço', with: 'Rua Estados Unidos, 1030 - Jardins'
    expect(page).to have_field 'Cidade', with: 'São Paulo'
    expect(page).to have_field 'Estado', with: 'SP'
    expect(page).to have_field 'CEP', with: '01234123'
    expect(page).to have_field 'Descrição', with: 'Melhor Buffet da região. Cowabunga'
  end

  it 'successfully' do
    owner = Owner.create!(name: 'Splinter Yoshi', email: 'splinter@email.com', password: 'password')
    Buffet.create!(brand_name: 'Teenage Mutant Ninja Turtles', corporate_name: 'TMNT Splinter LTDA',
                   registration_number: '88392017000182', phone: '11912341234',
                   email: 'contato@tmntsplinter.com', address: 'Rua Estados Unidos, 1030 - Jardins',
                   city: 'São Paulo', state: 'SP', zip_code: '01234123',
                   description: 'Melhor Buffet da região. Cowabunga', payment: 'PIX', owner:)

    login_as owner, scope: :owner
    visit root_path
    click_on 'Teenage Mutant Ninja Turtles'
    click_on 'Editar Buffet'
    fill_in 'Nome fantasia', with: 'Turma do Smilingüido'
    fill_in 'Razão social', with: 'Smilingüido e sua turma LTDA'
    fill_in 'CNPJ', with: '90178217000403'
    fill_in 'Telefone', with: '11900007777'
    fill_in 'E-mail', with: 'contato@turmadosmilinguido.com'
    fill_in 'Endereço', with: 'Av Formiga Atômica, 707 - Savassi'
    fill_in 'Cidade', with: 'Belo Horizonte'
    fill_in 'Estado', with: 'MG'
    fill_in 'CEP', with: '30204767'
    fill_in 'Descrição', with: 'Smilinguido e sua turma são a melhor companhia'
    fill_in 'Formas de pagamento', with: 'Cartão de Débito'
    click_on 'Atualizar Buffet'

    expect(page).to have_content 'Buffet atualizado com sucesso'
    expect(page).to have_content 'Buffet Turma do Smilingüido'
    expect(page).to have_content 'Razão social: Smilingüido e sua turma LTDA'
    expect(page).to have_content 'CNPJ: 90178217000403'
    expect(page).to have_content 'Telefone: 11900007777'
    expect(page).to have_content 'E-mail: contato@turmadosmilinguido.com'
    expect(page).to have_content 'Endereço: Av Formiga Atômica, 707 - Savassi'
    expect(page).to have_content 'CEP: 30204767'
    expect(page).to have_content 'Belo Horizonte - MG'
    expect(page).to have_content 'Descrição: Smilinguido e sua turma são a melhor companhia'
    expect(page).to have_content 'Proprietário: Splinter Yoshi'
  end

  it 'fill fields blank' do
    owner = Owner.create!(name: 'Splinter Yoshi', email: 'splinter@email.com', password: 'password')
    Buffet.create!(brand_name: 'Teenage Mutant Ninja Turtles', corporate_name: 'TMNT Splinter LTDA',
                   registration_number: '88392017000182', phone: '11912341234',
                   email: 'contato@tmntsplinter.com', address: 'Rua Estados Unidos, 1030 - Jardins',
                   city: 'São Paulo', state: 'SP', zip_code: '01234123',
                   description: 'Melhor Buffet da região. Cowabunga', payment: 'PIX', owner:)

    login_as owner, scope: :owner
    visit root_path
    click_on 'Teenage Mutant Ninja Turtles'
    click_on 'Editar Buffet'
    fill_in 'Nome fantasia', with: ''
    fill_in 'Razão social', with: ''
    fill_in 'CNPJ', with: ''
    fill_in 'Telefone', with: ''
    fill_in 'E-mail', with: ''
    fill_in 'Endereço', with: ''
    fill_in 'Cidade', with: ''
    fill_in 'Estado', with: ''
    fill_in 'CEP', with: ''
    fill_in 'Descrição', with: ''
    fill_in 'Formas de pagamento', with: ''
    click_on 'Atualizar Buffet'

    expect(page).to have_content 'Atente-se aos erros abaixo:'
    expect(page).to have_content 'Nome fantasia não pode ficar em branco'
    expect(page).to have_content 'Razão social não pode ficar em branco'
    expect(page).to have_content 'CNPJ não pode ficar em branco'
    expect(page).to have_content 'Telefone não pode ficar em branco'
    expect(page).to have_content 'E-mail não pode ficar em branco'
    expect(page).to have_content 'Endereço não pode ficar em branco'
    expect(page).to have_content 'Cidade não pode ficar em branco'
    expect(page).to have_content 'Estado não pode ficar em branco'
    expect(page).to have_content 'CEP não pode ficar em branco'
    expect(page).to have_content 'Formas de pagamento não pode ficar em branco'
    expect(page).not_to have_content 'Proprietário é obrigatório(a)'
  end
end
