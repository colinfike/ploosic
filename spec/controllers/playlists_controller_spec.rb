require 'rails_helper'

RSpec.describe PlaylistsController, 'GET #show' do
  it 'should return with 200 OK' do
    playlist = create(:playlist, :has_tracks)
    get :show, params: { id: playlist.id }
    expect(response.status).to eq(200)
  end
end
