class ShopAdminController < ApplicationController
  layout 'shop_admin'

  def authorize_shop
    unless cookies['shop_code'].present?
      redirect_to shop_path, alert: 'Needs Shop Authentication'
    end
  end
end
