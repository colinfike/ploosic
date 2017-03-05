class TrackUserStat < ApplicationRecord
  belongs_to :track
  belongs_to :user

  validates :track, :user, presence: true
end
