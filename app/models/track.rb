class Track < ApplicationRecord
  belongs_to :site

  has_many :track_playlists
  has_many :playlists, through: :track_playlists

  validates :site, :url, presence: true
  # validates :site, :url, :name, presence: true
  validates :url, format: { with: /https:\/\/.*youtu\.be|https:\/\/.*youtube|https:\/\/.*soundcloud|https:\/\/.*bandcamp/,
    message: "must be valid soundcloud/youtube/bancamp url" }
end
