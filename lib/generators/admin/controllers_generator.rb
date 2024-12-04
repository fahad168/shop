require "rails/generators"
require "rails/generators/migration"

module Admin
  module Generators
    class ControllersGenerator < Rails::Generators::Base
      include Rails::Generators::Migration
      source_root File.expand_path("templates/admin", __dir__)
      MAIN_PATH = "app/controllers/shop/admin"

      # Copying controller templates
      def copy_controllers
        template "controllers/shop_admin_controller.rb", "app/controllers/shop_admin_controller.rb"
        template "controllers/shop_controller.rb", "#{MAIN_PATH}/shop_controller.rb"
        template "controllers/dashboard_controller.rb", "#{MAIN_PATH}/dashboard_controller.rb"
        template "controllers/products_controller.rb", "#{MAIN_PATH}/products_controller.rb"
        template "controllers/settings_controller.rb", "#{MAIN_PATH}/settings_controller.rb"
      end

      # Adding routes
      def add_routes
        route <<-RUBY
          # Admin Shop Routes
          resources :shop, controller: 'shop/admin/shop' do
            collection do
              post :by_code
              post :by_name
            end
          end
          namespace :shop do
            namespace :admin do
              resources :dashboard do
                collection do
                  get :pie_chart
                end
              end
              resources :products do
                collection do
                  get :variant_fields
                  delete :multiple_destroy
                  get :variant_info
                end
              end
              resources :settings
            end
          end
        RUBY
      end
    end
  end
end
