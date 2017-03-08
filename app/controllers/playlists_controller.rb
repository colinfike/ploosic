class PlaylistsController < ApplicationController
  before_action :get_playlist

  def show
  end

  private

  def get_playlist
    @playlist = Playlist.find_by(id: params[:id])
  end
end
