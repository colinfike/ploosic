require 'rails_helper'

RSpec.feature "user views their playlist", type: :feature do
  scenario "they see a newly created playlist" do
    visit "/playlists"

    click_on 'Create Playlist'

    expect(page).render_template(:show)
    # as a user
    # I visit the "my playlist" page for the first time
    # I see a blank playlist created for me
  end

  # they see their existing playlist

end
