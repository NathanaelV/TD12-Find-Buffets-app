require 'rails_helper'

describe 'User view homepage' do
  it 'views the application name' do
    visit root_path

    expect(page).to have_content 'Buffets'
    expect(page).to have_link 'Buffets', href: root_path
    expect(page).not_to have_content 'Criar Evento'
  end
end
