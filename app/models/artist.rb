# frozen_string_literal: true

class Artist < ApplicationRecord
  has_many :albums
  has_many :tracks
  has_many :release_sales, through: :albums
  has_many :sales, through: :tracks
  validates_uniqueness_of :name

  def make_statement
    r_sales = release_sales
    t_sales = sales

    r_artist_share = r_sales.sum(:artist_share)
    r_label_share = r_sales.sum(:label_share)

    t_artist_share = t_sales.sum(:artist_share)
    t_label_share = t_sales.sum(:label_share)

    statement = {}

    statement[:overview] = {
      revenues: r_artist_share + t_artist_share + r_label_share + t_label_share,
      label_share: r_label_share + t_label_share,
      artist_share: r_artist_share + t_artist_share
    }

    statement[:releases] = {
      revenues: r_artist_share + r_label_share,
      label_share: r_label_share,
      artist_share: r_artist_share,
      details: Sale.share_by_release(id)
    }

    statement[:tracks] = {
      revenues: t_artist_share + t_label_share,
      label_share: t_label_share,
      artist_share: t_artist_share,
      details: Sale.share_by_track(id)
    }

    statement
  end
end
