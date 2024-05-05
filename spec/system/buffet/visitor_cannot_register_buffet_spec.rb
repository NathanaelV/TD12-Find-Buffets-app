require 'rails_helper'

describe 'Visitor cannot register Buffet' do
  it 'do not view form' do
    visit new_buffet_path

    expect(page).not_to have_content 'Cadastrar Buffet'
    expect(current_path).to eq new_owner_session_path
  end
end
