class Playlist < ApplicationRecord
  belongs_to :user
  has_many :track_playlists
  has_many :tracks, through: :track_playlists

  validate :user, :presence
end
