class Track < ApplicationRecord
  belongs_to :artist
  has_many :albums, through: :album_tracks
  include AbstractSaleable

  validates_uniqueness_of :isrc
end
