# frozen_string_literal: true

class Sale < ApplicationRecord
  belongs_to :saleable, polymorphic: true

  def self.royalty_rate
    {
      'Download Albums' => 30,
      'Subscription Audio Streams' => 50,
      'Ad-Supported Audio Streams' => 50,
      'Non-interactive Radio' => 50,
      'Cloud Match Units' => 50,
      'Mid-Tier Subscription Audio Streams' => 50,
      'Physical Sales' => 15,
      'Download Tracks' => 30
    }
  end

  def self.init_from_json(json_record)
    saleable_ref = json_record['product code']
    sale_type = json_record['Trans Type']
    type_description = json_record['Trans Type Description']

    saleable = %w[PS DA].include?(sale_type) ? Album.find_by(upc: saleable_ref) : Track.find_by(isrc: saleable_ref)

    # doing revenue by a million so we only compute int's
    # better for perfs. fin-tech secrets ;)
    revenue = json_record['Label Share Net Receipts'] * 10**6
    artist_share = ((revenue * royalty_rate[type_description]) / 100).round
    label_share = revenue - artist_share

    Sale.find_or_initialize_by(
      saleable: saleable,
      transaction_type: type_description,
      revenue: revenue,
      label_share: label_share,
      artist_share: artist_share,
      period: json_record['Period'],
      activity_period: json_record['Activity Period'],
      territory: json_record['Territory']
    )
  end

  def sale_rate
    royalty_rate[transaction_type]
  end

  def self.share_by_instance saleable_i
    revenue = saleable_i.sales.sum(:revenue)
    artist_share = saleable_i.sales.sum(:artist_share)
    label_share = revenue - artist_share

    {
      track: saleable_i,
      revenue: revenue,
      artist_share: artist_share,
      label_share: label_share
    }
  end

  def self.share_by_track(artist_id)
    Track.includes(:sales).where(artist_id: artist_id).map do |t|
      Sale.share_by_instance t
    end
  end

  def self.share_by_release(artist_id)
    Album.includes(:sales).where(artist_id: artist_id).map do |t|
      Sale.share_by_instance t
    end
  end
end
