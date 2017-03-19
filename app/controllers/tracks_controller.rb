class TracksController < ApplicationController

  def create
    track = Track.add_to_playlist(params[:track_url], params[:playlist_id])
    flash[:error] = "An error occurred trying to add track to playlist" if !track.save
    redirect_to track.playlist
  end
end
