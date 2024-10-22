module CartManagement
  class Cart

    def initialize(user_id)
      @user_id = user_id
    end

    def create_cart
      @cart = Cart.new(user_id: @user_id)
      if @cart.save
        'Cart Created Successfully'
      else
        @cart.errors.full_messages
      end
    end
  end
end