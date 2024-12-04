# frozen_string_literal: true

require_relative "shop_methods/version"
require "rails/railtie"
require_relative "generators/user/models_generator"
require_relative "generators/user/controllers_generator"
require_relative "generators/user/views_generator"
require_relative "generators/admin/models_generator"
require_relative "generators/admin/controllers_generator"
require_relative "generators/admin/views_generator"
require_relative "shop_methods/cart"
require_relative "shop_methods/cart_item"
require_relative "shop_methods/product"
require_relative "shop_methods/size"
require_relative "shop_methods/variant"

module Shop
  class Railtie < Rails::Railtie
    initializer "shop_methods.autoload" do |app|
      app.config.autoload_paths << File.expand_path("../shop_methods", __dir__)
      app.config.eager_load_paths << File.expand_path("../shop_methods", __dir__)
    end
  end
  class Error < StandardError; end
end
