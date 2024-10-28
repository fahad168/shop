namespace :shop do
  desc "Install Shop gem"
  task install: :environment do
    Rails::Generators.invoke("shop:install")
  end

  desc "Install Admin Side Panel"
  task install: :environment do
    Rails::Generators.invoke("shop:admin")
  end
end
