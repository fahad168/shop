# frozen_string_literal: true
class Size < ApplicationRecord
  belongs_to :variant, optional: true
  belongs_to :product, optional: true
end