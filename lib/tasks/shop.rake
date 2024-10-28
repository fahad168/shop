namespace :shop do
  desc "Install Shop gem"
  task install: :environment do
    Rails::Generators.invoke("shops:install")
  end
end
