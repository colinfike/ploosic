require 'rails_helper'

# This is kind of a dupe of the other feature test
RSpec.feature "user views a playlist", type: :feature do
  scenario 'they see each track on the page' do
    playlist = create(:playlist, :has_tracks)
    visit playlist_path(playlist)
    playlist.tracks.each do |track|
      expect(page).to have_css '.track .track__name', :text => track.name
    end
  end

  scenario 'they see the player on the page' do
    playlist = create(:playlist, :has_tracks)
    visit playlist_path(playlist)
    expect(page).to have_css 'div.player'

    # FIXME: Don't want to overload the assertions here but I want to check that all
    # the buttons are here. Could use a request helper but I just want to
    # check that the selector is here. Will use this for now.
    expect(page).to have_css '.player__play'
    expect(page).to have_css '.player__next'
    expect(page).to have_css '.player__previous'
    expect(page).to have_css '.player__shuffle'
  end
end
