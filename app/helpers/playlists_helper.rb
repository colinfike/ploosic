module PlaylistsHelper

  # Also not a fan of using concat here but it's cleaner than using two different
  # helpers, right? Cleaner then having the html right in the view? Maybe not.
  def render_track(track)
    content_tag :div, class: "track" do
      concat(content_tag :span, track.name, class: 'track__name', style: 'color: #001A23;')
      concat(content_tag :span, "By #{track.artist_name}", class: 'track__artist_name', style: 'color: #001A23;margin-left:20px;')
    end
  end

  def render_data_div(tracks)
    track_json = []
    tracks.each do |track|
      track_json << track.as_json
    end
    content_tag :div, nil, class: 'none', id: 'playlist-data', data: { playlist: track_json }
  end

  def render_playlist_link(user_id)
    if current_user
      link_to 'View Playlist', playlist_path(current_user.playlist)
    else
      link_to 'Create Playlist', playlists_path, method: :post
    end
  end
end
