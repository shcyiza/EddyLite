class Album < ApplicationRecord
  belongs_to :artist
  has_many :album_tracks
  has_many :tracks, through: :album_tracks
  has_many :release_sales, as: :saleable, class_name: 'Sale'

  include AbstractSaleable
end
