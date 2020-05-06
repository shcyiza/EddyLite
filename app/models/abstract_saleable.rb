# frozen_string_literal: true

module AbstractSaleable
  extend ActiveSupport::Concern

  def self.included(base)
    base.has_many :sales, as: :saleable

    def base.share_by_instance
      map do |t|
        revenue = t.sales.sum(:revenue)
        artist_share = t.sales.sum(:artist_share)
        label_share = revenue - artist_share

        {
          track: t,
          revenue: revenue,
          artist_share: artist_share,
          label_share: label_share
        }
      end
    end
  end
end
