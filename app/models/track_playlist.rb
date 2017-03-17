class TrackPlaylist < ApplicationRecord
  belongs_to :track
  belongs_to :playlist
  validates :track, :playlist, presence: true
end
