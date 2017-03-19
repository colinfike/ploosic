module PlaylistsHelper
  def render_track(track)
    content_tag :div, class: "track" do
      content_tag :span, track.name, class: 'track__name', style: 'color: #001A23;'
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

  def render_player
    content_tag :div, class: 'player' do
    end
  end
end
