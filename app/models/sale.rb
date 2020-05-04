# frozen_string_literal: true

class Sale < ApplicationRecord
  belongs_to :saleable, polymorphic: true

  def self.royalty_rate
    {
      'Download Albums' => 0.30,
      'Subscription Audio Streams' => 0.50,
      'Ad-Supported Audio Streams' => 0.50,
      'Non-interactive Radio' => 0.50,
      'Cloud Match Units' => 0.50,
      'Mid-Tier Subscription Audio Streams' => 0.50,
      'Physical Sales' => 0.15,
      'Download Tracks' => 0.30
    }
  end

  def sale_rate
    royalty_rate[transaction_type]
  end
end
