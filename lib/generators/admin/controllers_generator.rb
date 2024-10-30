require "rails/generators"
require "rails/generators/migration"

module Admin
  module Generators
    class ControllersGenerator < Rails::Generators::Base
      include Rails::Generators::Migration
      source_root File.expand_path("templates/admin", __dir__)

      # Copying controller templates
      def copy_controllers
        template "controllers/shop_admin_controller.rb", "app/controllers/shop_admin_controller.rb"
        template "controllers/shop_controller.rb", "app/controllers/admin/shop_controller.rb"
        template "controllers/dashboard_controller.rb", "app/controllers/admin/dashboard_controller.rb"
        template "controllers/products_controller.rb", "app/controllers/admin/products_controller.rb"
      end

      # Adding routes
      def add_routes
        route <<-RUBY
          # Admin Shop Routes
          resources :shop, controller: 'admin/shop' do
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
    end
  end
end
