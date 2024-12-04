class Shop::User::HomeController < ShopUserController

  def index
    @other_products = Product.all
  end

end
