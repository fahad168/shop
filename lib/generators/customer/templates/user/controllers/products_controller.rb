class Shop::User::ProductsController < ShopUserController
  before_action :find_product

  def show; end

  def variant
    @variant = Variant.find_by(id: params[:id])
    color = ColorName.get("#{@variant.color}")
    render json: { sizes: render_to_string(partial: 'shop/user/products/size', locals: { variant: @variant }),
                   slider: render_to_string(partial: 'shop/user/products/product_slider', locals: { variant: @variant }),
                   color: color, size_id: @variant.sizes.first.id, product_id: @variant.product.id,
                   variant_id: @variant.id, price: @variant.product.price}
  end

  private

  def find_product
    @product = Product.find_by(id: params[:id])
  end
end
