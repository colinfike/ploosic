require 'rails_helper'

RSpec.feature "user views their playlist", type: :feature do
  scenario "they see a newly created playlist" do
    visit "/playlists"
    click_link 'Create Playlist'

    expect(page).not_to have_selector '.track__name'
  end

  # This is not great. Need to move to controller possibly to test session?
  scenario "they see their existing playlist" do
    visit "/playlists"
    click_link 'Create Playlist'

    visit "/playlists"
    # click_link 'View Playlist'

    expect(page).not_to have_selector '.track__name'
  end
end
