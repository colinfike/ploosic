class TracksController < ApplicationController

  # I'm not really sure how much error checking is enough.
  # You can end up checking the data all the way up. I think
  # it's a safe assumption that a playlist will exist if this
  # action is being hit.
  def create
    # doc.css('h1').first.children[2].children[0].text artist
    # doc.css('h1').first.children.first.children.text song name
    playlist = Track.add_to_playlist(params[:track_url], params[:playlist_id])
    if playlist
      redirect_to playlist
    else
      flash[:error] = "An error occurred trying to add track to playlist"
      redirect_back(fallback_location: root_path)
    end
  end
end
