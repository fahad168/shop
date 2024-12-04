# frozen_string_literal: true
class Variant < ApplicationRecord
  belongs_to :product
  has_many :sizes, dependent: :destroy
  has_many :images, dependent: :destroy
end