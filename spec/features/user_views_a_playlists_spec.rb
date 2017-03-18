require 'rails_helper'

RSpec.feature "user views a playlist", type: :feature do
  scenario 'they see each track on the page' do
    playlist = create(:playlist, :has_tracks)
    visit playlist_path(playlist)
    playlist.tracks.each do |track|
      expect(page).to have_css '.track .track__name', :text => track.name
    end
  end
end
