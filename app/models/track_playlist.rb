class TrackPlaylist < ApplicationRecord
  belongs_to :track
  belongs_to :playlist
end
