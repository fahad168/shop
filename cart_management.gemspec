# frozen_string_literal: true

require_relative "lib/cart_management/version"

Gem::Specification.new do |spec|
  spec.name = "cart_management"
  spec.version = CartManagement::VERSION
  spec.authors = ["Fahadbutt"]
  spec.email = ["buttf5169@gmail.com"]

  spec.summary = "Cart"
  spec.description = "Cart Management"
  # spec.homepage = "TODO: Put your gem's website or public repo URL here."
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  # spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  # spec.metadata["homepage_uri"] = spec.homepage
  # spec.metadata["source_code_uri"] = "TODO: Put your gem's public repo URL here."
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir["lib/**/*", "sig/**/*", "spec/**/*", "lib/generators/install_generator.rb"]
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.post_install_message = <<-MESSAGE
  Thank you for installing CartManagement!

  To complete the installation, please run:

      rails cart_management:install
MESSAGE

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
