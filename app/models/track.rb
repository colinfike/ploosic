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
    track = Track.create(url: track_url)
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
    return if name || artist_name
    if site_id == 1
      fetch_soundcloud_info
    else
      fetch_youtube_info
    end
  end

  def fetch_soundcloud_info
    begin
      doc = Nokogiri::HTML(open(url))
      if doc
        self.artist_name = doc.css('h1').first.children[2].children[0].text
        self.name = doc.css('h1').first.children.first.children[0].text
      end
    rescue => e
      logger.info "URL not found in fetch_soundcloud_info"
    end
    self.artist_name = "Unknown" if artist_name.nil?
    self.name = "Unknown" if name.nil?
  end

  def fetch_youtube_info
    begin
      video_response = JSON.parse(RestClient.get("https://www.googleapis.com/youtube/v3/videos?part=snippet&id=#{get_youtube_id}&key=#{ENV['YOUTUBE_API_KEY']}").body)
      channel_id = video_response['items'][0]['snippet']['channelId']
      title = video_response['items'][0]['snippet']['title']

      channel_response = JSON.parse(RestClient.get("https://www.googleapis.com/youtube/v3/channels?part=snippet&id=#{channel_id}&key=#{ENV['YOUTUBE_API_KEY']}").body)
      channel_name = channel_response['items'][0]['snippet']['title']

      self.artist_name = channel_name
      self.name = title
    rescue => e
      self.artist_name = 'Unknown'
      self.name = 'Unknown'
    end
  end

  def get_youtube_id
    if url.include?('youtu.be')
      url.split('/').last
    else
      url.split('=').last
    end
  end
end
