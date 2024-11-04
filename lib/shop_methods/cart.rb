module ShopMethods
  class Cart
    attr_reader :user_id

    def initialize(user_id)
      @user_id = user_id
      @cart = ::Cart.find_by(user_id: @user_id)
    end

    # Get Cart For User
    def specific_user_cart
      cart = ::Cart.where(user_id: @user_id)
      if cart.present?
        { message: 'Cart Found Successfully', cart: cart, status: :found }
      else
        { message: 'No Cart Found For This User', cart: nil, status: :not_found }
      end
    end

    # Create Cart
    def create
      @cart = ::Cart.find_or_initialize_by(user_id: @user_id)
      return { message: @cart.errors.full_messages, cart: nil, status: :unprocessable_entity } unless @cart.save

      { message: 'Cart Created Successfully', cart: @cart, status: :created }
    end

    # Delete Cart
    def delete
      return { message: @cart.errors.full_messages, cart: @cart, status: :unprocessable_entity } unless @cart.destroy

      { message: 'Cart Deleted Successfully', cart: nil, status: :deleted }
    end

    # Clear Cart
    def clear
      return { message: "Items Can't be destroyed", cart: @cart, status: :unprocessable_entity } unless @cart.cart_items.destroy_all && @cart.update(total_amount: 0.0)

      { message: 'Cart Cleared Successfully', cart: @cart, status: :updated }
    end
  end
end
