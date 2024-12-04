require "rails/generators"
require "rails/generators/migration"

module Customer
  module Generators
    class ControllersGenerator < Rails::Generators::Base
      include Rails::Generators::Migration
      source_root File.expand_path("templates/user", __dir__)
      MAIN_PATH = "app/controllers/shop/user"

      # Copying controller templates
      def copy_controllers
        template "controllers/shop_user_controller.rb", "app/controllers/shop_user_controller.rb"
        template "controllers/home_controller.rb", "#{MAIN_PATH}/home_controller.rb"
        template "controllers/products_controller.rb", "#{MAIN_PATH}/products_controller.rb"
        template "controllers/cart_controller.rb", "#{MAIN_PATH}/cart_controller.rb"
      end

      # Adding routes
      def add_routes
        route <<-RUBY
          # User Shop Routes
          namespace :shop do
            namespace :user do
              resources :home
              resources :products do
                collection do
                  get :variant
                end
              end
              resources :cart do
                collection do
                  post :add_to_cart
                  post :remove_from_cart
                end
              end
            end
          end
        RUBY
      end
    end
  end
end
