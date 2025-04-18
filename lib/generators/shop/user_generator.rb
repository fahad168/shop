# frozen_string_literal: true

require "rails/generators"
require "rails/generators/migration"

module Shop
  module Generators
    class UserGenerator < Rails::Generators::Base
      include Rails::Generators::Migration
      source_root File.expand_path("templates/user", __dir__)

      def copy_migration
        migration_template "migrations/create_carts.rb", "db/migrate/create_carts.rb"
        migration_template "migrations/create_cart_items.rb", "db/migrate/create_cart_items.rb"
      end

      def copy_models
        template "models/cart.rb", "app/models/cart.rb"
        template "models/cart_item.rb", "app/models/cart_item.rb"
      end

      def copy_controllers
        template "controllers/products_controller.rb", "app/controllers/user/products_controller.rb"
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
