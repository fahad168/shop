namespace :shop do
  desc "Install Shop gem"
  task install: :environment do
    Rails::Generators.invoke("admin:user")
  end

  desc "Install Admin Side Panel"
  task install: :environment do
    Rails::Generators.invoke("admin:models")
  end
end
