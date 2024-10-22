# frozen_string_literal: true
class Size < ApplicationRecord
  belongs_to :variant
  belongs_to :product, optional: true
end