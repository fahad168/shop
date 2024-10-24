# frozen_string_literal: true

require_relative "shop/version"
require "rails/railtie"
require_relative "generators/install_generator"
require_relative 'shop/cart'

module CartManagement
  class Railtie < Rails::Railtie
    initializer "shop.install_migration" do |app|
    end
  end
  class Error < StandardError; end
end
