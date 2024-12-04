namespace :shop do
  desc "Admin Models Generator"
  task install: :environment do
    Rails::Generators.invoke("admin:models")
  end

  desc "Admin Controller And Routes Generator"
  task install: :environment do
    Rails::Generators.invoke("admin:controllers")
  end

  desc "Admin Views Generator"
  task install: :environment do
    Rails::Generators.invoke("admin:views")
  end

  desc "User Models Generator"
  task install: :environment do
    Rails::Generators.invoke("user:models")
  end

  desc "User Controller And Routes Generator"
  task install: :environment do
    Rails::Generators.invoke("user:controllers")
  end

  desc "User Views Generator"
  task install: :environment do
    Rails::Generators.invoke("user:views")
  end
end
