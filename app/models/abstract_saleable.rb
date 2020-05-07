# frozen_string_literal: true

module AbstractSaleable
  extend ActiveSupport::Concern

  def self.included(base)
    base.has_many :sales, as: :saleable
  end
end
