class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :variant
  belongs_to :product
  belongs_to :size
end