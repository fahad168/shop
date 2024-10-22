require 'rails/generators'
require 'rails/generators/migration'

module CartManagement
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include Rails::Generators::Migration
      source_root File.expand_path("templates", __dir__)

      def copy_migration
        migration_template "create_carts.rb", "db/migrate/create_carts.rb"
        migration_template "create_products.rb", "db/migrate/create_products.rb"
        migration_template "create_variants.rb", "db/migrate/create_variants.rb"
        migration_template "create_sizes.rb", "db/migrate/create_sizes.rb"
        migration_template "create_cart_items.rb", "db/migrate/create_cart_items.rb"
      end

      def copy_models
        template 'cart.rb', 'app/models/cart.rb'
        template 'cart_item.rb', 'app/models/cart_item.rb'
        template 'product.rb', 'app/models/product.rb'
        template 'variant.rb', 'app/models/variant.rb'
        template 'size.rb', 'app/models/size.rb'
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