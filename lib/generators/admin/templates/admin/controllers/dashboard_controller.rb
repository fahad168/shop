class Admin::DashboardController < ShopAdminController
  before_action :authorize_shop

  def index; end
end