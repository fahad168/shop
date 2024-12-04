require "shop_methods/cart_item"
class Shop::User::CartController < ShopUserController
  before_action :authenticate_user!

  def index
    @cart_items = current_user.cart.cart_items.order(updated_at: :desc)
  end

  def add_to_cart
    @cart_item = current_user.cart.cart_items.find_by(product_id: params[:product_id], variant_id: params[:variant_id], size_id: params[:size_id])
    if @cart_item.present?
      @response = ShopMethods::CartItem.new(current_user.cart.id, params[:product_id], params[:variant_id], params[:size_id]).update_quantity(@cart_item.id, params[:quantity].to_i, params[:amount].to_f, params[:key])
    else
      @response = ShopMethods::CartItem.new(current_user.cart.id, params[:product_id], params[:variant_id], params[:size_id]).create(params[:quantity], params[:amount].to_f)
    end
    render json: @response
  end

  def remove_from_cart
    @cart_item = current_user.cart.cart_items.find_by(id: params[:item_id])
    if @cart_item.present?
      @response = ShopMethods::CartItem.new(current_user.cart.id, nil, nil, nil).delete(@cart_item.id)
      debugger
      render json: { items: render_to_string(partial: 'shop/user/cart/cart_items', locals: { cart_items: current_user.cart.cart_items }), message: @response[:message] }, status: :ok
    end
  end
end
