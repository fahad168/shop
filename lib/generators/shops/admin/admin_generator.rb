require "rails/generators"
require "rails/generators/migration"

module Shop
  module Generators
    class AdminGenerator < Rails::Generators::Base
      include Rails::Generators::Migration
      source_root File.expand_path("templates", __dir__)

      # Copying migration templates
      def copy_migration
        migration_template "migrations/create_shop.rb", "db/migrate/create_shops.rb"
        migration_template "migrations/create_products.rb", "db/migrate/create_products.rb"
        migration_template "migrations/create_variants.rb", "db/migrate/create_variants.rb"
        migration_template "migrations/create_sizes.rb", "db/migrate/create_sizes.rb"
      end

      # Copying model templates
      def copy_models
        template "models/shop.rb", "app/models/shop.rb"
        template "models/product.rb", "app/models/product.rb"
        template "models/variant.rb", "app/models/variant.rb"
        template "models/size.rb", "app/models/size.rb"
      end

      # Copying controller templates
      def copy_controllers
        template "controllers/shops_controller.rb", "app/controllers/shops/shops_controller.rb"
      end

      # Copying view templates
      def copy_views
        template "views/shops/index.html.erb.tt", "app/views/shops/index.html.erb"
      end

      # Adding routes
      def add_routes
        route <<-RUBY
          namespace :shops do
            resources :shops
          end
        RUBY
      end

      # Setting migration numbers
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
