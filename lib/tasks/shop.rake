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
end
