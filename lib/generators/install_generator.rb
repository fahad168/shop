require "rails/generators"
require "rails/generators/migration"

module Shop
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include Rails::Generators::Migration
      source_root File.expand_path("templates", __dir__)

      def copy_migration
        migration_template "create_shops.rb", "db/migrate/create_shops.rb"
        migration_template "create_carts.rb", "db/migrate/create_carts.rb"
        migration_template "create_products.rb", "db/migrate/create_products.rb"
        migration_template "create_variants.rb", "db/migrate/create_variants.rb"
        migration_template "create_sizes.rb", "db/migrate/create_sizes.rb"
        migration_template "create_cart_items.rb", "db/migrate/create_cart_items.rb"
      end

      def copy_models
        template "shop.rb", "app/models/shops.rb"
        template "cart.rb", "app/models/cart.rb"
        template "cart_item.rb", "app/models/cart_item.rb"
        template "product.rb", "app/models/product.rb"
        template "variant.rb", "app/models/variant.rb"
        template "size.rb", "app/models/size.rb"
      end

      # def copy_controllers
      #   template 'shops_controller.rb', 'app/controllers/shops/shops_controller.rb'
      #   # template 'shops_controller.rb.tt', 'app/controllers/shops/shops_controller.rb'
      #   # template 'products_controller.rb.tt', 'app/controllers/shops/products_controller.rb'
      #   # template 'variants_controller.rb.tt', 'app/controllers/shops/variants_controller.rb'
      #   # template 'sizes_controller.rb.tt', 'app/controllers/shops/sizes_controller.rb'
      # end

      # def copy_views
      #   template "shops/index.html.erb.tt", "app/views/shops/shops/index.html.erb"
      # end

      # def add_routes
      #   route <<-RUBY
      #     namespace :shops do
      #       resources :shops
      #     end
      #   RUBY
      # end

      def self.next_migration_number(path)
        if @prev_migration_nr
          @prev_migration_nr += 1
        else
          @prev_migration_nr = Time.now.utc.strftime("%Y%m%d%H%M%S").to_i
        end
        @prev_migration_nr.to_s
      end
    end
  end
end