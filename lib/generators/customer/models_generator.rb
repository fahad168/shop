require "rails/generators"
require "rails/generators/migration"

module Customer
  module Generators
    class ModelsGenerator < Rails::Generators::Base
      include Rails::Generators::Migration
      source_root File.expand_path("templates/user", __dir__)

      # Copying migration templates
      def copy_migration
        migration_template "migrations/create_carts.rb", "db/migrate/create_carts.rb"
        migration_template "migrations/create_cart_items.rb", "db/migrate/create_cart_items.rb"
      end

      def copy_models
        template "models/cart.rb", "app/models/cart.rb"
        template "models/cart_item.rb", "app/models/cart_item.rb"
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
