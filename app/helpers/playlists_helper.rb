module PlaylistsHelper

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

  def render_errors(flash)
    if flash[:error]
      content_tag :div, class: 'row columns ten offset-by-one error' do
        content_tag :span, flash[:error]
      end
    end
  end

  def render_create_link(playlist)
    if playlist.id == 1
      link_to 'Create Playlist', playlists_path, method: :post, class: 'button columns four offset-by-four', style: 'margin-bottom: 15px;'
    end
  end
end
