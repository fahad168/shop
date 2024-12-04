# frozen_string_literal: true

require_relative "lib/shop_methods/version"

Gem::Specification.new do |spec|
  spec.name = "e-commerce_shop"
  spec.version = ShopMethods::VERSION
  spec.authors = ["Fahadbutt"]
  spec.email = ["buttf5169@gmail.com"]

  spec.summary = "A gem to manage shopping carts, products, and variants with flexible and customizable features for e-commerce platforms."
  spec.description = "This gem provides a comprehensive solution for managing shopping carts, products, and variants in e-commerce applications. It supports flexible product creation, updates, and variant handling, along with efficient cart management functionality."
  # spec.homepage = "TODO: Put your gem's website or public repo URL here."
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  # spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  # spec.metadata["homepage_uri"] = spec.homepage
  # spec.metadata["source_code_uri"] = "TODO: Put your gem's public repo URL here."
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir["lib/shop_methods/**/*.rb", "sig/**/*", "spec/**/*", "lib/generators/views_generator.rb",
                   "lib/generators/models_generator.rb", "lib/generators/controllers_generator.rb",
                   "lib/generators/views_generator.rb"]
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.post_install_message = <<-MESSAGE
    Thank you for installing Shop Gem!
    With This Gem You can get every feature shop can have by using commands below.

    Shop Admin Side:
      For generating shop owner models, please run:
          rails g admin:models
  
      For generating shop owner controllers and routes, please run:
          rails g admin:controllers
  
      For generating shop owner views, please run:
          rails g admin:views
  
    To Use User side you will need a devise or any other authentication gem.
      For Devise Installation, Follow These Steps 

        Add "gem 'devise'" in Gemfile

        please run these commands:
            rails generate devise:install
            rails generate devise user
            rails generate devise:views

        After That Add these in user model
          has_one_attached :profile_image, dependent: :destroy
          has_one :cart, dependent: :destroy
          after_create :create_cart
          def create_cart
            @cart = ::Cart.find_or_initialize_by(user_id: self.id)
            @cart.save
          end

    Shop User Side:
      For generating shop user models, please run:
          rails g customer:models
  
      For generating shop user controllers and routes, please run:
          rails g customer:controllers
  
      For generating shop user views, please run:
          rails g customer:views

    For Uploading Images on Local (Compulsory)
      Active Storage Installation Required, please run:
          rails g active_storage:install

    After Doing all the steps, Run Command for Assets Compilation
      rails assets:precompile

  MESSAGE

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "breadcrumbs_on_rails"
  spec.add_dependency "country_select"
  spec.add_dependency "color"
  spec.add_dependency "color_name"
  spec.add_dependency "will_paginate"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
