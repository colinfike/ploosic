class User < ApplicationRecord
  has_one :playlist
  after_save :create_playlist

  private

  def create_playlist
    Playlist.create(user: self) if !self.playlist
  end
end
