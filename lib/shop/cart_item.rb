module Shop
  class CartItem
    attr_reader :cart_id, :product_id, :variant_id, :quantity, :size_id

    def initialize(cart_id, product_id = nil, variant_id = nil, size_id = nil)
      @cart = ::Cart.find_by(id: cart_id) if cart_id
      @product = ::Product.find_by(id: product_id) if product_id
      @variant = ::Variant.find_by(id: variant_id) if variant_id
      @size = ::Size.find_by(id: size_id) if size_id
    end

    # Cart Items
    def cart_items
      cart_items = @cart.cart_items.order(created_at: :desc)
      if cart_items.present?
        { message: 'Cart Items Found Successfully', cart_items: cart_items, status: :found }
      else
        { message: 'No Cart Items Found', cart_items: nil, status: :not_found }
      end
    end

    # Creates a new Cart Item
    def create(quantity, amount)
      return { message: 'Cart not found', cart_item: nil, status: :not_found } unless @cart

      cart_item = ::CartItem.new(cart_id: @cart.id, product_id: @product.id, variant_id: @variant.id, size_id: @size.id, quantity: quantity, amount: amount)
      if cart_item.save
        update_cart_amount(amount, 'add')
        { message: 'Item Added Successfully', cart_item: cart_item, status: :created }
      else
        { message: cart_item.errors.full_messages, cart_item: nil, status: :unprocessable_entity }
      end
    end

    # Update Cart Item Quantity
    def update_quantity(cart_item_id, quantity, amount, key)
      return { message: 'Cart Item not found', cart_item: nil, status: :not_found } unless (cart_item = ::CartItem.find_by(id: cart_item_id))

      quantity = key == 'add' ? +quantity : -quantity
      new_amount = key == 'add' ? +amount : -amount
      old_quantity = cart_item.quantity
      old_amount = cart_item.amount
      if cart_item.update(quantity: old_quantity + quantity, amount: old_amount + new_amount)
        update_cart_amount(amount, key)
        { message: "Item #{key.capitalize}ed Successfully", cart_item: cart_item, status: :updated }
      else
        { message: cart_item.errors.full_messages, cart_item: nil, status: :unprocessable_entity }
      end
    end

    # Deletes the Cart Item
    def delete(cart_item_id)
      return { message: 'Cart Item not found', cart_item: nil, status: :not_found } unless (cart_item = ::CartItem.find_by(id: cart_item_id))

      if cart_item.destroy
        update_cart_amount(cart_item.amount, 'remove')
        { message: 'Cart Item Deleted Successfully', cart_item: nil, status: :deleted }
      else
        { message: cart_item.errors.full_messages, cart_item: nil, status: :unprocessable_entity }
      end
    end

    private

    def update_cart_amount(amount, key)
      previous_amount = @cart.total_amount
      new_amount = if key == 'add'
                     +amount
                   else
                     -amount
                   end
      @cart.update(total_amount: previous_amount + new_amount)
    end
  end
end
