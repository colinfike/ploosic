require 'rails_helper'

RSpec.feature "user visits proof of concept page", type: :feature do
  scenario 'they see the header on the page' do
    visit root_path
    expect(page).to have_css '.header'
  end
end
