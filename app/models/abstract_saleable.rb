module AbstractSaleable
  extend ActiveSupport::Concern

  included do
    has_many :sales, as: :saleable
  end
end