# spec/generators/install_generator_spec.rb
require "generators/install_generator"

RSpec.describe Shop::Generators::InstallGenerator, type: :generator do
  destination File.expand_path('../../tmp/generators', __FILE__)

  # Include the generator test case behavior
  include Rails::Generators::TestCase::Behavior

  before(:all) do
    run_generator
  end

  it "generates a migration file" do
    expect(destination_root).to have_structure {
      directory("db") do
        directory("migrate") do
          migration_file = file(/.*create_carts.rb/)
          expect(migration_file).to exist
        end
      end
    }
  end
end
