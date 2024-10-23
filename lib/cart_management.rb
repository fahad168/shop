# frozen_string_literal: true

require_relative "cart_management/version"
require "rails/railtie"
require_relative "generators/install_generator"
require_relative 'cart_management/cart'

module CartManagement
  class Railtie < Rails::Railtie
    initializer "cart_management.install_migration" do |app|
    end
  end
  class Error < StandardError; end
end
