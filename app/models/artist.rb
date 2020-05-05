class Artist < ApplicationRecord
  has_many :albums
  has_many :tracks

  validates_uniqueness_of :name
end
