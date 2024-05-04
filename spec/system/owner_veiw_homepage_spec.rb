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
    buffet = Buffet.create!(brand_name: 'TMNT Buffet', owner:)

    login_as owner, scope: :owner
    visit root_path

    expect(page).to have_content 'TMNT Buffet'
    expect(page).to have_link 'TMNT Buffet', href: buffet_path(buffet)
  end
end
