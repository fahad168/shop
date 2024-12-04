class Shop < ApplicationRecord
  has_many :products, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :code, presence: true, uniqueness: true

  has_one_attached :shop_image, dependent: :destroy
end
