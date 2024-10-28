namespace :shop do
  desc "Install Shop gem"
  task install: :environment do
    Rails::Generators.invoke("shops:install")
  end

  desc "Run Admin Generator"
  task admin: :environment do
    Rails::Generators.invoke("shops:admin")
  end
end