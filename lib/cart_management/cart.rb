module CartManagement
  class Cart
    attr_reader :user_id

    def initialize(user_id)
      @user_id = user_id
    end

    def create_cart
      @cart = ::Cart.find_or_initialize_by(user_id: @user_id)
      if @cart.save
        'Cart Created Successfully'
      else
        @cart.errors.full_messages
      end
    end
  end
end
