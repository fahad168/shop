class Shop < ApplicationRecord
  has_many :products, dependent: :destroy
end
