class Admin::ShopsController < ShopAdminController
  before_action :check_cookies
  before_action :find_shop, only: %w[by_name by_code]

  def index; end

  def new
    @shop = Shop.new
  end

  def create
    @shop = Shop.new(name: params[:shop][:name], code: "SH#{SecureRandom.hex(5)}")
    if @shop.save
      flash[:notice] = "Shop Created Successfully"
      redirect_to shop_path
    else
      flash[:alert] = @shop.errors.full_messages
      render :new
    end
  end


  def edit; end

  def update; end

  def destroy; end

  def by_name
    render json: { message: "Shop found successfully" }, status: :ok
  end

  def by_code
    if params[:code] == @shop.code
      cookies.permanent["shop_code"] = @shop.code
      redirect_to admin_dashboard_path, notice: "Shop Authenticated Successfully"
    else
      redirect_to shop_path, notice: "Shop code is incorrect"
    end
  end

  private

  def find_shop
    unless (@shop = Shop.find_by(name: params[:name]))
      render json: { message: "No admin found with this name" }, status: :not_found
    end
  end

  def check_cookies
    if cookies["shop_code"].present?
      redirect_to admin_dashboard_path
    end
  end
end
