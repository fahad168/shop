require "generators/install_generator"

RSpec.describe Shop::Generators::InstallGenerator, type: :generator do
  # Set the destination for the generated files
  destination File.expand_path("../../tmp/generators", __FILE__)

  # Prepare the destination before running the generator
  before(:all) do
    prepare_destination
    run_generator
  end

  it "generates a migration file" do
    expect(destination_root).to have_structure {
      directory("db") do
        directory("migrate") do
          file("create_carts.rb")
        end
      end
    }
  end

  it "generates the expected model files" do
    expect(destination_root).to have_structure {
      directory("app/models") do
        file("cart.rb")
        file("product.rb")
        file("size.rb")
        # Add more model files as necessary
      end
    }
  end
end
