require "rails/generators"
require "rails/generators/migration"

module Admin
  module Generators
    class ViewsGenerator < Rails::Generators::Base
      include Rails::Generators::Migration
      source_root File.expand_path("templates/admin", __dir__)
      MAIN_PATH = "app/views/shop/admin"

      # Generate Layouts
      def create_layout_file
        create_file "app/views/layouts/shop_admin.html.erb", <<~EOF
          <!DOCTYPE html>
            <html class="">
            <head>
              <title>Admin Shop</title>
              <%= csrf_meta_tags %>
              <%= csp_meta_tag %>
              <%= stylesheet_link_tag "application", "data-turbo-track": "reload" %>
              <meta name="viewport" content="width=device-width,initial-scale=1">
              <script src="https://cdn.tailwindcss.com"></script>
              <link href="https://cdn.jsdelivr.net/npm/tailwindcss@3.0.0/dist/tailwind.min.css" rel="stylesheet">
              <script>
                  tailwind.config = {
                      content: ["./*.html"],
                      theme: {
                          extend: {
                              colors: {
                                  primary: {
                                      blue: {
                                          light: "#00ccdd"
                                      }
                                  }
                              }
                          }
                      },
                      darkMode: "class"
                  };
              </script>
              <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
              <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
              <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css" />
              <script src="https://unpkg.com/flowbite@1.5.3/dist/flowbite.js"></script>
              <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-nice-select/1.1.0/js/jquery.nice-select.min.js"></script>
              <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-nice-select/1.1.0/css/nice-select.min.css">
              <script src="https://cdnjs.cloudflare.com/ajax/libs/chosen/1.8.7/chosen.jquery.min.js"></script>
              <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/chosen/1.8.7/chosen.min.css" />
              <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/mdbassit/Coloris@latest/dist/coloris.min.css"/>
              <script src="https://cdn.jsdelivr.net/gh/mdbassit/Coloris@latest/dist/coloris.min.js"></script>
            </head>
            <body class="bg-white dark:bg-gray-800">
            <%= render 'shop/admin/shared/toastr' %>
            <% if @current_shop.present? %>
              <%= render 'shop/admin/shared/sidebar' %>
              <div class="p-4 sm:ml-64">
                <div class="mt-[3rem]">
                  <%= render_breadcrumbs %>
                </div>
                <%= yield %>
              </div>
            <% else %>
              <%= yield %>
            <% end %>
            </body>
            </html>
        EOF
      end

      # Copying view templates
      def copy_views
        index_path = File.join(__dir__, "templates/admin/views/shop", "index.html.erb")
        index_content = File.read(index_path)
        create_file "#{MAIN_PATH}/shop/index.html.erb", <<~EOF
          #{index_content}
        EOF

        new_shop_path = File.join(__dir__, "templates/admin/views/shop", "new.html.erb")
        new_shop_content = File.read(new_shop_path)
        create_file "#{MAIN_PATH}/shop/new.html.erb", <<~EOF
          #{new_shop_content}
        EOF

        template "views/shared/field_loader.html.erb", "#{MAIN_PATH}/shared/_field_loader.html.erb"

        submit_btn_path = File.join(__dir__, "templates/admin/views/shared", "submit_button.html.erb")
        submit_content = File.read(submit_btn_path)
        create_file "#{MAIN_PATH}/shared/_submit_button.html.erb", <<~EOF
          #{submit_content}
        EOF

        template "views/shared/success_svg.html.erb", "#{MAIN_PATH}/shared/_success_svg.html.erb"

        toastr_path = File.join(__dir__, "templates/admin/views/shared", "toastr.html.erb")
        toastr_content = File.read(toastr_path)
        create_file "#{MAIN_PATH}/shared/_toastr.html.erb", <<~EOF
          #{toastr_content}
        EOF

        template "views/dashboard/index.html.erb", "#{MAIN_PATH}/dashboard/index.html.erb"
      end

      def copy_dashboard
        sidebar_path = File.join(__dir__, "templates/admin/views/shared", "sidebar.html.erb")
        sidebar_content = File.read(sidebar_path)
        create_file "#{MAIN_PATH}/shared/_sidebar.html.erb", <<~EOF
          #{sidebar_content}
        EOF
      end

      def copy_products
        index_path = File.join(__dir__, "templates/admin/views/products", "index.html.erb")
        index_content = File.read(index_path)
        create_file "#{MAIN_PATH}/products/index.html.erb", <<~EOF
          #{index_content}
        EOF

        new_path = File.join(__dir__, "templates/admin/views/products", "new.html.erb")
        new_content = File.read(new_path)
        create_file "#{MAIN_PATH}/products/new.html.erb", <<~EOF
          #{new_content}
        EOF

        form_path = File.join(__dir__, "templates/admin/views/products", "form.html.erb")
        form_content = File.read(form_path)
        create_file "#{MAIN_PATH}/products/_form.html.erb", <<~EOF
          #{form_content}
        EOF

        variant_path = File.join(__dir__, "templates/admin/views/products", "variant.html.erb")
        variant_content = File.read(variant_path)
        create_file "#{MAIN_PATH}/products/_variant.html.erb", <<~EOF
          #{variant_content}
        EOF

        edit_variant_path = File.join(__dir__, "templates/admin/views/products", "variant_edit.html.erb")
        edit_variant_content = File.read(edit_variant_path)
        create_file "#{MAIN_PATH}/products/_variant_edit.html.erb", <<~EOF
          #{edit_variant_content}
        EOF
      end

      def copy_stylesheets
        stylesheet_path = File.join(__dir__, "templates/admin/assets/stylesheets", "shop.css")
        stylesheet_content = File.read(stylesheet_path)
        create_file "app/assets/stylesheets/shop.css", <<~EOF
          #{stylesheet_content}
        EOF
      end

      def copy_js
        js_path = File.join(__dir__, "templates/admin/assets/javascript", "shop.js")
        js_content = File.read(js_path)
        create_file "app/javascript/shop.js", <<~EOF
          #{js_content}
        EOF
      end

      def copy_image_assets
        image_path = File.join(__dir__, "templates/admin/assets/images", "cross_circle.svg")
        image_content = File.read(image_path)
        create_file "app/assets/images/cross_circle.svg", <<~EOF
          #{image_content}
        EOF
      end

      def copy_helpers
        shop_helper_path = File.join(__dir__, "templates/admin/helpers", "shop_helper.rb")
        shop_helper_content = File.read(shop_helper_path)
        create_file "app/helpers/shop_helper.rb", <<~EOF
          #{shop_helper_content}
        EOF

        breadcrumb_helper_path = File.join(__dir__, "templates/admin/helpers", "breadcrumbs_helper.rb")
        breadcrumb_helper_content = File.read(breadcrumb_helper_path)
        create_file "app/helpers/breadcrumbs_helper.rb", <<~EOF
          #{breadcrumb_helper_content}
        EOF
      end
    end
  end
end
