class Shop::Admin::ProductsController < ShopAdminController
  before_action :authorize_shop

  def index
    @products = @current_shop.products.order(created_at: :desc)
  end

  def new
    @product = Product.new
    add_breadcrumb "New"
  end

  def create
    if (@product = Product.create(product_params.merge(country: params[:product][:country])))
      variant_params(@product, params)
      redirect_to shop_admin_products_path, notice: 'Product Created Successfully'
    else
      redirect_to new_shop_admin_products_path, alert: @product.errors.full_messages.first
    end
  end

  def edit; end

  def update; end

  def destroy
    if @product.destroy
      redirect_to shop_admin_products_path
    end
  end

  def multiple_destroy
    products = Product.where(id: JSON.parse(params[:ids]))
    if products.destroy_all
      redirect_to shop_admin_products_path
    end
  end

  def variant_fields
    render json: { entries: render_to_string(partial: 'shop/admin/products/variant', locals: { count: params[:count], f: params[:f] }) }
  end

  private

  def product_params
    params.permit(:name, :price, :description, :delivery_fee).merge(shop_id: @current_shop.id)
  end

  def variant_params(product, params)
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
  end

end
