class Track < ApplicationRecord
  belongs_to :site

  has_many :track_playlists
  has_many :playlists, through: :track_playlists

  validates :site, :url, presence: true
  validates :url, format: { with: /https:\/\/.*youtu\.be|https:\/\/.*youtube\.|https:\/\/.*soundcloud\.|https:\/\/.*bandcamp\./,
    message: "must be valid soundcloud/youtube/bancamp url" }

  before_validation :set_site
  before_save :fetch_track_information

  def self.add_to_playlist track_url, playlist_id
    playlist = Playlist.find_by(id: playlist_id)
    track = Track.create(url: track_url, name: "TempName: #{Time.zone.now}")
    if playlist && track.errors.empty?
      playlist.tracks << track
      return playlist
    else
      return false
    end
  end

  private

  def set_site
    return if site || url.blank?
    if self.url.match(/https:\/\/.*soundcloud\./)
      self.site = Site.find_by(name: 'SoundCloud')
    elsif self.url.match(/https:\/\/.*youtu\.be|https:\/\/.*youtube\./)
      self.site = Site.find_by(name: 'YouTube')
    end
  end

  def fetch_track_information
    return if name || artist
    if site_id = 1
      fetch_soundcloud_info(url)
    else
      fetch_youtube_info(url)
    end
  end

  def fetch_soundcloud_info(url)
  end

  def fetch_youtube_info(url)
  end
end
