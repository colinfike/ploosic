module PlaylistsHelper

  # Also not a fan of using concat here but it's cleaner than using two different
  # helpers, right? Cleaner then having the html right in the view? Maybe not.
  def render_track(track)
    content_tag :div, class: "track columns ten offset-by-one" do
      concat(content_tag :span, track.name, class: 'track__name')
      concat(content_tag :span, "by #{track.artist_name}", class: 'track__artist_name')
      concat(content_tag :i, nil, class: 'fa fa-play-circle-o track__play', aria_hidden: "true")
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

  def render_site_icon(site_id)
    if site_id == 1
      content_tag :i, nil, class: "fa fa-lg fa-soundcloud track__icon", aria_hidden: true
    else
      content_tag :i, nil, class: "fa fa-lg fa-youtube-square track__icon track__icon--youtube", aria_hidden: true
    end
  end
end
