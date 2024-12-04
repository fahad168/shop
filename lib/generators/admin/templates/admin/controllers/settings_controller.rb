class Shop::Admin::SettingsController < ShopAdminController
  before_action :authorize_shop

  def index; end

  def create
    if @current_shop.update(shop_params)
      redirect_to shop_admin_settings_path, notice: 'Changes Saved Successfully'
    else
      redirect_to shop_admin_settings_path, notice: @current_shop.errors.full_messages.first
    end
  end

  private

  def shop_params
    params.permit(:name, :name_color, :header_color, :sidebar_color, :sidebar_content_color, :sidebar_content_hover_color, :shop_image)
  end
end
