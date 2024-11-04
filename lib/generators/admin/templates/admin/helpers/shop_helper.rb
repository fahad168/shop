module ShopHelper

  def country_select_with_flags(object, method, priority_countries = nil, options = {}, html_options = {})
    countries = ISO3166::Country.countries
    country_options = countries.map do |country|
      ["#{country.emoji_flag} #{country.iso_short_name}", country.alpha2]
    end

    country_options.unshift(['Select Country', ''])
    select_options = options_for_select(country_options, priority_countries[:selected])
    html_options[:class] = "country_select bg-gray-100 text-gray-900 mb-6 text-sm rounded-lg block w-full outline-none"
    html_options[:required] = 'true'
    select_tag = select(object, method, select_options, options, html_options)
    select_tag.html_safe
  end

end
