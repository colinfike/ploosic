class Track < ApplicationRecord
  belongs_to :user
  belongs_to :site

  validates :user, :site, :url, :name, presence: true
  validates :site, format: { with: /https:\/\/.*youtu\.be|https:\/\/.*youtube|https:\/\/.*soundcloud|https:\/\/.*bandcamp/,
    message: "must be valid soundcloud/youtube/bancamp url" }
end
