# frozen_string_literal: true
class Product < ApplicationRecord
  has_many :variants, dependent: :destroy

  validates :name, presence: true
  validates :price, presence: true
end