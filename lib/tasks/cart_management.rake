namespace :cart_management do
  desc "Install CartManagement gem"
  task install: :environment do
    Rails::Generators.invoke("cart_management:install")
  end
end
