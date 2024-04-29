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
    buffet = Buffet.create!(brand_name: 'TMNT Buffet', city: 'São Paulo', state: 'SP', owner:)

    visit root_path

    expect(page).to have_content 'TMNT Buffet'
    expect(page).to have_content 'SP - São Paulo'
    expect(page).to have_link 'TMNT Buffet', href: buffet_path(buffet)
  end
end
