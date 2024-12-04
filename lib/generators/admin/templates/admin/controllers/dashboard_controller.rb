class Shop::Admin::DashboardController < ShopAdminController
  before_action :authorize_shop

  def index; end

  def pie_chart
    @categories = Product.pluck(:categories).flatten.uniq
    category_data = []
    drilldown_series = []
    @categories.each do |category|
      products = Product.where("categories @> ARRAY[?]::varchar[]", category)
      category_data << {
        name: category,
        y: products.count,
        drilldown: category
      }
      drilldown_series << {
        name: 'Total Variants',
        id: category,
        data: [
          *products.map do |product|
            [
              product.name,
              product.variants.count,
            ]
          end
        ]
      }
    end
    render json: { data: category_data, drilldown_series: drilldown_series }, status: :ok
  end
end