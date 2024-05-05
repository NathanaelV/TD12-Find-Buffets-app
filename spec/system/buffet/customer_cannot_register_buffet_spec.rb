require 'rails_helper'

describe 'Customer cannot register Buffet' do
  it 'do not view form' do
    customer = Customer.create!(name: 'Dragon Shiryu', cpf: '665.455.630-50', email: 'shiryu@email.com',
                                password: 'shiryu123')

    login_as customer, scope: :customer
    visit new_buffet_path

    expect(page).not_to have_content 'Cadastrar Buffet'
    expect(current_path).to eq new_owner_session_path
  end
end
