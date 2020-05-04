# frozen_string_literal: true

class Sale < ApplicationRecord
  belongs_to :saleable, polymorphic: true

  def sale_rate
    case transaction_type
    when 'Download Albums'
      0.30
    when 'Subscription Audio Streams'
      0.50
    when 'Ad-Supported Audio Streams'
      0.50
    when 'Non-interactive Radio'
      0.50
    when 'Cloud Match Units'
      0.50
    when 'Mid-Tier Subscription Audio Streams'
      0.50
    when 'Physical Sales'
      0.15
    when 'Download Tracks'
      0.30
    end
  end
end
