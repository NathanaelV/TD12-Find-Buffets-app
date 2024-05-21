require 'rails_helper'

describe 'Owner view homepage' do
  it 'without register the buffet' do
    owner = Owner.create!(name: 'Splinter', email: 'splinter@email.com', password: 'password')

    login_as owner, scope: :owner
    visit root_path

    expect(page).to have_content 'Cadastrar Buffet'
  end

  it 'with register buffet' do
    owner = Owner.create!(name: 'Splinter', email: 'splinter@email.com', password: 'password')

    buffet = Buffet.create!(brand_name: 'Teenage Mutant Ninja Turtles', corporate_name: 'TMNT Splinter LTDA',
                            registration_number: '88392017000182', phone: '11912341234',
                            email: 'contato@tmntsplinter.com', address: 'Rua Estados Unidos, 1030 - Jardins',
                            city: 'São Paulo', state: 'SP', zip_code: '01234123',
                            description: 'Melhor Buffet da região. Cowabunga', payment: 'PIX, Cartão de Débito', owner:)

    login_as owner, scope: :owner
    visit root_path

    expect(page).to have_content 'Teenage Mutant Ninja Turtles'
    expect(page).to have_link 'Teenage Mutant Ninja Turtles', href: buffet_path(buffet)
  end

  xit 'and is redirect to his buffet' do
    # Add on home#index: redirect_to current_owner.buffet if owner_signed_in?
    # current_path to eq buffet_path(buffet)
    # Other texts on show buffet
  end
end
