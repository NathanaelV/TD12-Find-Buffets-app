require 'rails_helper'

describe 'Routes Errors' do
  it 'returns 404' do
    visit 'non-existen_route'

    expect(page).to have_content('404')
    expect(page).to have_content('Página não encontrada')
    expect(page).not_to have_content('Routing Error')
    expect(page).not_to have_content('No route matches')
  end
end
