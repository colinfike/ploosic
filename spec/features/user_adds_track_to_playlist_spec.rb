require 'rails_helper'

RSpec.feature "user adds track to playlist", type: :feature do
  scenario 'they see track in the playlist' do
    track_url = 'https://soundcloud.com/badministrator/come-get-it'

    visit '/playlists'
    click_on 'Create Playlist'

    fill_in 'track_url', with: track_url
    click_on 'track_submit'

    # TODO: Need to implement fetching of information of each track since just
    # the link isn't going to cut it
    expect(page).to have_selector '.track__name'
  end
end
