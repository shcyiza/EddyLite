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
    revenue = json_record['Label Share Net Receipts']
    artist_share = (revenue * royalty_rate[type_description]) / 100
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
end
