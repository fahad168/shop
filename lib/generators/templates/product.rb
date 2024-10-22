# frozen_string_literal: true
class Product < ApplicationRecord
  has_many :variants, dependent: :destroy
  has_many :sizes, dependent: :destroy
end