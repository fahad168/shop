require "rails/generators"
require "rails/generators/migration"

module Admin
  module Generators
    class ModelsGenerator < Rails::Generators::Base
      include Rails::Generators::Migration
      source_root File.expand_path("templates/admin", __dir__)

      # Copying migration templates
      def copy_migration
        migration_template "migrations/create_shops.rb", "db/migrate/create_shops.rb"
        migration_template "migrations/create_products.rb", "db/migrate/create_products.rb"
        migration_template "migrations/create_variants.rb", "db/migrate/create_variants.rb"
        migration_template "migrations/create_sizes.rb", "db/migrate/create_sizes.rb"
      end

      # Copying model templates
      def copy_models
        template "models/admin.rb", "app/models/admin.rb"
        template "models/product.rb", "app/models/product.rb"
        template "models/variant.rb", "app/models/variant.rb"
        template "models/size.rb", "app/models/size.rb"
      end

      # Copying controller templates
      def copy_controllers
        template "controllers/shop_admin_controller.rb", "app/controllers/shop_admin_controller.rb"
        template "controllers/shops_controller.rb", "app/controllers/admin/shops_controller.rb"
        template "controllers/dashboard_controller.rb", "app/controllers/admin/dashboard_controller.rb"
        template "controllers/products_controller.rb", "app/controllers/admin/products_controller.rb"
      end

      # Copying view templates
      def copy_views
        template "views/shop_admin.html.erb", "app/views/layouts/shop_admin.html.erb"
        template "views/shops/index.html.erb", "app/views/admin/shops/index.html.erb"
        template "views/shops/new.html.erb", "app/views/admin/shops/new.html.erb"
        template "views/shared/field_loader.html.erb", "app/views/admin/shared/_field_loader.html.erb"
        template "views/shared/submit_button.html.erb", "app/views/admin/shared/_submit_button.html.erb"
        template "views/shared/success_svg.html.erb", "app/views/admin/shared/_success_svg.html.erb"
        template "views/dashboard/index.html.erb", "app/views/admin/dashboard/index.html.erb"
      end

      # Adding routes
      def add_routes
        route <<-RUBY
          # Admin Shop Routes
          resources :admin, controller: 'admin/shops' do
            collection do
              post :by_code
              post :by_name
            end
          end
          namespace :admin do
            resources :dashboard
            resources :products
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
