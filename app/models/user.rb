class User < ApplicationRecord
  validates :guest_hash, presence: true
end
