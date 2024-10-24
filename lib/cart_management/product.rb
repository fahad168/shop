module CartManagement
  class Product
    attr_reader :user_id, :name, :price, :description, :delivery_fee, :country

    def initialize(user_id)
      @user_id = user_id
    end

    # Specific User Products
    def specific_user_products(order, q)
      products = Product.where(user_id: @user_id).order(created_at: order)
      products = products.where('LOWER(name) ILIKE ? OR LOWER(country) ILIKE ? ', "%#{q.downcase}%") if q.present?
      if products.present?
        { message: 'Product Found Successfully', products: products, status: :found }
      else
        { message: 'No Product Found For This User', products: [], status: :not_found }
      end
    end

    # Creates a new product
    def create(name, price, description, delivery_fee, country)
      product = Product.new(user_id: @user_id, name: , price: ,description: , delivery_fee: , country: )
      if product.save
        { message: 'Product Created Successfully', product: product, status: :created }
      else
        { message: product.errors.full_messages, product: nil, status: :unprocessable_entity }
      end
    end

    # Updates an existing product
    def update(product_hash, product_id)
      return { message: 'Product not found', product: nil, status: :not_found } unless (product = Product.find_by(id: product_id))

      if product.update(product_hash)
        { message: 'Product Updated Successfully', product: product, status: :updated }
      else
        { message: product.errors.full_messages, product: nil, status: :unprocessable_entity }
      end
    end

    # Deletes the product
    def delete(product_id)
      return { message: 'Product not found', product: nil, status: :not_found } unless (product = Product.find_by(id: product_id))

      if product.destroy
        { message: 'Product Deleted Successfully', product: nil, status: :deleted }
      else
        { message: product.errors.full_messages, product: nil, status: :unprocessable_entity }
      end
    end
  end
end
