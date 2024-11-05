require 'shop_methods/product'
class Shop::Admin::ProductsController < ShopAdminController
  before_action :authorize_shop

  def index
    response = ShopMethods::Product.new(@current_shop.id).specific_shop_products(:desc, params[:q], params[:filter])
    @products = response[:products]
  end

  def new
    @product = Product.new
    add_breadcrumb "New"
  end

  def create
    response = ShopMethods::Product.new(@current_shop.id).create(params)
    if response[:status] == :created
      redirect_to shop_admin_products_path, notice: response[:message]
    else
      redirect_to new_shop_admin_products_path, alert: response[:message]
    end
  end

  def edit
    @product = Product.find_by(id: params[:id])
    add_breadcrumb @product.name
  end

  def update
    response =  ShopMethods::Product.new(@current_shop.id).update(params, params[:id])
    if response[:status] == :updated
      redirect_to shop_admin_products_path, notice: response[:message]
    else
      redirect_to shop_admin_products_path(id: params[:id]), alert: response[:message]
    end
  end

  def destroy
    response = ShopMethods::Product.new(@current_shop.id).delete_product(params[:id])
    if response[:status] == :created
      redirect_to shop_admin_products_path, notice: response[:message]
    else
      redirect_to shop_admin_products_path, alert: response[:message]
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
end
