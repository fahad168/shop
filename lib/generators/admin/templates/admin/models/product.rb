# frozen_string_literal: true
class Product < ApplicationRecord
  belongs_to :shop
  has_many :variants, dependent: :destroy

  validates :name, presence: true
  validates :price, presence: true

  scope :last_day, ->(products) { products.where('created_at >= ?', 1.day.ago) }
  scope :last_7_days, ->(products) { products.where('created_at >= ?', 7.days.ago) }
  scope :last_30_days, ->(products) { products.where('created_at >= ?', 30.days.ago) }
  scope :last_month, ->(products) { products.where('created_at >= ?', 1.month.ago.beginning_of_month).where('created_at < ?', Time.now.beginning_of_month) }
  scope :last_year, ->(products) { products.where('created_at >= ?', 1.year.ago) }
end