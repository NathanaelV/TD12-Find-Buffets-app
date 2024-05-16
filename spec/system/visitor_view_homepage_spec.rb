require 'rails_helper'

describe 'User view homepage' do
  it 'views the application name' do
    visit root_path

    expect(page).to have_content 'Buffets'
    expect(page).to have_link 'Buffets', href: root_path
    expect(page).not_to have_content 'Criar Evento'
  end

  it 'view buffets registered' do
    owner = Owner.create!(name: 'Splinter', email: 'splinter@email.com', password: 'password')

    buffet = Buffet.create!(brand_name: 'Teenage Mutant Ninja Turtles', corporate_name: 'TMNT Splinter LTDA',
                            registration_number: '88392017000182', phone: '11912341234',
                            email: 'contato@tmntsplinter.com', address: 'Rua Estados Unidos, 1030 - Jardins',
                            city: 'São Paulo', state: 'SP', zip_code: '01234123',
                            description: 'Melhor Buffet da região. Cowabunga', payment: 'PIX, Cartão de Débito', owner:)

    visit root_path

    expect(page).to have_content 'Teenage Mutant Ninja Turtles'
    expect(page).to have_content 'SP - São Paulo'
    expect(page).to have_link 'Teenage Mutant Ninja Turtles', href: buffet_path(buffet)
  end
end
