# frozen_string_literal: true

require_relative "shop/version"
require "rails/railtie"
# require_relative "generators/admin_generator"
require_relative "generators/install_generator"
require_relative "shop/cart"
require_relative "shop/cart_item"
require_relative "shop/product"
require_relative "shop/size"
require_relative "shop/variant"

module Shop
  class Railtie < Rails::Railtie
    initializer "shops.install_migration" do |app|
      app.config.autoload_paths << File.expand_path("../generators", __dir__)
    end
  end
  class Error < StandardError; end
end
