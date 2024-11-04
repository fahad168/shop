module BreadcrumbsHelper
  def render_breadcrumbs
    if breadcrumbs.any?
      breadcrumbs.each_with_index.map do |crumb, index|
        if index == breadcrumbs.size - 1
          content_tag(:span, crumb.name, class: "font-medium text-md leading-7 text-[#FF8717]")
        else
          link_to crumb.name, crumb.path, class: "font-normal text-md leading-7 hover:underline text-gray-700 dark:text-white"
        end
      end.join(content_tag(:span, '  >  ', class: "text-[#FF8717]")).html_safe
    end
  end
end
