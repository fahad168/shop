require "rails/generators"
require "rails/generators/migration"

module Shop
  module Generators
    class AdminGenerator < Rails::Generators::Base
      include Rails::Generators::Migration
      source_root File.expand_path("templates", __dir__)

      def copy_migration
        migration_template "shops/migrations/create_shop.rb", "db/migrate/create_shops.rb"
        migration_template "shops/migrations/create_products.rb", "db/migrate/create_products.rb"
        migration_template "shops/migrations/create_variants.rb", "db/migrate/create_variants.rb"
        migration_template "shops/migrations/create_sizes.rb", "db/migrate/create_sizes.rb"
      end

      def copy_models
        template "shops/models/shop.rb", "app/models/shop.rb"
        template "shops/models/product.rb", "app/models/product.rb"
        template "shops/models/variant.rb", "app/models/variant.rb"
        template "shops/models/size.rb", "app/models/size.rb"
      end

      def copy_controllers
        template "shops/controllers/shops_controller.rb", "app/controllers/shop/shops_controller.rb"
      end

      def copy_views
        template "shops/views/index.html.erb.tt", "app/views/shop/shops/index.html.erb"
      end

      def add_routes
        route <<-RUBY
          namespace :shop do
            resources :shops
          end
        RUBY
      end

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