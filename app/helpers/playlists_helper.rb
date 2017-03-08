module PlaylistsHelper
  def render_track(track)
    content_tag :div, class: "track" do
      content_tag :span, track.name, class: 'track__name'
    end
  end
end
