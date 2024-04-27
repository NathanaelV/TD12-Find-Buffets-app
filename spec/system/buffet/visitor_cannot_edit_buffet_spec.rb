require 'rails_helper'

describe 'Visitor cannot edit Buffet' do
  it 'do not view form' do
    owner = Owner.create!(name: 'Splinter Yoshi', email: 'splinter@email.com', password: 'password')
    Buffet.create!(brand_name: 'TMNT Buffet', corporate_name: 'TMNT Splinter LTDA',
                   registration_number: '88392017000182', phone: '11912341234',
                   email: 'contato@tmntsplinter.com', address: 'Rua Estados Unidos, 1030 - Jardins',
                   city: 'São Paulo', state: 'SP', zip_code: '01234123',
                   description: 'Melhor Buffet da região. Cowabunga', payment: 'PIX', owner:)

    visit root_path
    click_on 'TMNT Buffet'

    expect(page).not_to have_content 'Editar Buffet'
  end
end
