module ShopMethods
  class Product
    attr_reader :shop_id, :name, :price, :description, :delivery_fee, :country

    def initialize(shop_id)
      @shop_id = shop_id
    end

    # Specific User Products
    def specific_shop_products(order, q, filter)
      products = ::Product.where(shop_id: @shop_id).order(created_at: order)
      products = products.where('LOWER(name) ILIKE :query OR LOWER(country) ILIKE :query', query: "%#{q.downcase}%") if q.present?
      products = if filter.present?
                    case filter
                    when 'last_day'
                      Product.last_day(products)
                    when 'last_7_days'
                      Product.last_7_days(products)
                    when 'last_30_days'
                      Product.last_30_days(products)
                    when 'last_month'
                      Product.last_month(products)
                    else
                      Product.last_year(products)
                    end
                  end
      if products.present?
        { message: 'Product Found Successfully', products: products, status: :found }
      else
        { message: 'No Product Found For This User', products: [], status: :not_found }
      end
    end

    # Creates a new product
    def create(params)
      if (product = ::Product.create(name: params[:name], price: params[:price], description: params[:description], delivery_fee: params[:delivery_fee], shop_id: @shop_id, country: params[:product][:country]))
        variant_params = params.select { |key, _| key.to_s.start_with?('variant') }
        variant_params.each_value do |variant_param|
          variant = product.variants.create(color: variant_param[:color], name: variant_param[:name])
          if variant_param[:size].present?
            variant_param[:size].each_with_index do |size, index|
              variant.sizes.create(name: size, in_stock: variant_param[:quantity][index])
            end
          end
          if variant_param[:variant_images].present?
            variant_param[:variant_images].each do |image|
              variant_image = Image.create(variant_id: variant.id)
              variant_image.image.attach(image)
            end
          end
        end
        { message: 'Product Created Successfully', product: product, status: :created }
      else
        { message: product.errors.full_messages, product: nil, status: :unprocessable_entity }
      end
    end

    # Updates an existing product
    def update(product_hash, product_id)
      return { message: 'Product not found', product: nil, status: :not_found } unless (product = ::Product.find_by(id: product_id))

      if product.update(product_hash)
        { message: 'Product Updated Successfully', product: product, status: :updated }
      else
        { message: product.errors.full_messages, product: nil, status: :unprocessable_entity }
      end
    end

    # Deletes the product
    def delete_product(product_id)
      return { message: 'Product not found', product: nil, status: :not_found } unless (product = ::Product.find_by(id: product_id))

      if product.destroy
        { message: 'Product Deleted Successfully', product: nil, status: :deleted }
      else
        { message: product.errors.full_messages, product: nil, status: :unprocessable_entity }
      end
    end
  end
end
