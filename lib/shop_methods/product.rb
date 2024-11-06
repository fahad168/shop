require 'shop_methods/size'
require 'shop_methods/variant'

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
      if products.present?
        { message: 'Product Found Successfully', products: products, status: :found }
      else
        { message: 'No Product Found For This User', products: [], status: :not_found }
      end
    end

    # Creates a new product
    def create(params)
      if (product = ::Product.create(name: params[:name], categories: JSON.parse(params[:categories]).map { |cat| cat["value"] }, price: params[:price], description: params[:description], delivery_fee: params[:delivery_fee], shop_id: @shop_id, country: params[:product][:country]))
        ShopMethods::Product.variant_params(params, product)
        { message: 'Product Created Successfully', product: product, status: :created }
      else
        { message: product.errors.full_messages, product: nil, status: :unprocessable_entity }
      end
    end

    # Updates an existing product
    def update(params, product_id)
      return { message: 'Product not found', product: nil, status: :not_found } unless (product = ::Product.find_by(id: product_id))

      if product.update(name: params[:name], categories: JSON.parse(params[:categories]).map { |cat| cat["value"] }, price: params[:price], description: params[:description], delivery_fee: params[:delivery_fee], shop_id: @shop_id, country: params[:product][:country])
        ShopMethods::Product.update_variant_params(params, product)
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

    def self.update_variant_params(params, product)
      variants = product.variants.where.not(id: JSON.parse(params[:products_color_ids]))
      variants.destroy_all
      product.variants.each do |variant|
        previous_variants = params.select { |key, _| key == variant.id.to_s }
        ShopMethods::Product.handle_updated_variants(previous_variants, params, variant)
      end
      ShopMethods::Product.variant_params(params, product)
    end

    def self.handle_updated_variants(previous_variants, params, variant)
      previous_variants&.each do |p_variant|
        variant_data = {
          color: p_variant.second[:color],
          name: p_variant.second[:name]
        }
        variant.update(variant_data)
        ShopMethods::Product.handle_sizes(variant, p_variant)
        ShopMethods::Product.handle_images(variant, p_variant)
      end
    end

    def self.handle_sizes(variant, p_variant)
      unless variant.sizes.pluck(:name) == p_variant.second[:size] && variant.sizes.pluck(:in_stock) == p_variant.second[:in_stock]
        variant.sizes.destroy_all
        size_data = []
        p_variant.second[:size].each_with_index do |size, index|
          size_data << {
            name: size,
            in_stock: p_variant.second[:in_stock][index],
            variant_id: variant.id
          }
        end
        ShopMethods::Size.new.create_multiple_sizes(size_data)
      end
    end

    def self.handle_images(variant, p_variant)
      if p_variant.second[:image_ids].present?
        images = if p_variant.second[:image_ids] != "[]"
                   variant.images.where.not(id: JSON.parse(p_variant.second[:image_ids]))
                 else
                   variant.images
                 end
        images.destroy_all
      end
      if p_variant.second[:variant_images].present?
        p_variant.second[:variant_images]&.each do |image|
          if image.present?
            variant_image = ::Image.create(variant_id: variant.id)
            variant_image.image.attach(image)
          end
        end
      end
    end

    def self.variant_params(params, product)
      variant_params = params.select { |key, _| key.to_s.start_with?('variant') }
      variant_params.each_value do |variant_param|
        response = ShopMethods::Variant.new.create(product.id, variant_param[:name], variant_param[:color])
        if variant_param[:size].present?
          variant_param[:size].each_with_index do |size, index|
            ShopMethods::Size.new.create_single_size(response[:variant].id, size, nil, variant_param[:in_stock][index])
          end
        end
        if variant_param[:variant_images].present?
          variant_param[:variant_images].each do |image|
            variant_image = Image.create(variant_id: response[:variant].id)
            variant_image.image.attach(image)
          end
        end
      end
    end
  end
end
