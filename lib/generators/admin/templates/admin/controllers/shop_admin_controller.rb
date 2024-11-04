class ShopAdminController < ApplicationController
  before_action :set_breadcrumb
  layout 'shop_admin'

  def authorize_shop
    if cookies['shop_code'].present?
      @current_shop = Shop.find_by(code: cookies['shop_code'])
    else
      redirect_to shop_index_path, alert: ['Needs Shop Authentication']
    end
  end

  def set_breadcrumb
    add_breadcrumb "Dashboard", '/shop/admin/dashboard'
    unless params[:controller].include?('dashboard')
      add_breadcrumb "#{params[:controller].split('/').third.capitalize}", "/shop/admin/#{request.path.split('/').fourth}"
    end
  end
end
