class Sale < ApplicationRecord
  belongs_to :saleable, polymorphic: true
end
