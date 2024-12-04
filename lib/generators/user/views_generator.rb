# frozen_string_literal: true

require "rails/generators"
require "rails/generators/migration"

module User
  module Generators
    class ViewsGenerator < Rails::Generators::Base
      include Rails::Generators::Migration
      source_root File.expand_path("templates/user", __dir__)
      MAIN_PATH = "app/views/shop/user"

      def create_layout_file
        create_file "app/views/layouts/shop_user.html.erb", <<~EOF
          <!DOCTYPE html>
          <html class="">
          <head>
            <title>User Shopping</title>
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
            <script src="https://cdn.jsdelivr.net/npm/@splidejs/splide@4.1.4/dist/js/splide.min.js"></script>
            <link href="https://cdn.jsdelivr.net/npm/@splidejs/splide@4.1.4/dist/css/splide.min.css" rel="stylesheet">
          </head>
          <body class="bg-white dark:bg-gray-800">
            <div class="absolute left-[50%] flex flex-row justify-center items-center bg-transparent h-screen" style="z-index: 13; display: none" id="loader">
              <div class="loader"></div>
            </div>
            <div class="hidden fixed inset-0 w-screen bg-black/70 transition-all duration-300" style="z-index: 12" id="overlay"></div>
            <%= render 'shop/admin/shared/toastr' %>
            <%= render 'shop/user/shared/navbar' %>
            <%= yield %>
          </body>
          </html>
        EOF
      end

      def copy_views
        # Cart Views
        cart_index_path = File.join(__dir__, "templates/user/views/cart", "index.html.erb")
        cart_index_content = File.read(cart_index_path)
        create_file "#{MAIN_PATH}/cart/index.html.erb", <<~EOF
          #{cart_index_content}
        EOF

        cart_item_path = File.join(__dir__, "templates/user/views/cart", "cart_item.html.erb")
        cart_item_content = File.read(cart_item_path)
        create_file "#{MAIN_PATH}/cart/_cart_item.html.erb", <<~EOF
          #{cart_item_content}
        EOF

        order_summary_path = File.join(__dir__, "templates/user/views/cart", "order_summary.html.erb")
        order_summary_content = File.read(order_summary_path)
        create_file "#{MAIN_PATH}/cart/_order_summary.html.erb", <<~EOF
          #{order_summary_content}
        EOF

        # Home Views
        home_index_path = File.join(__dir__, "templates/user/views/home", "index.html.erb")
        home_index_content = File.read(home_index_path)
        create_file "#{MAIN_PATH}/home/index.html.erb", <<~EOF
          #{home_index_content}
        EOF

        slider_path = File.join(__dir__, "templates/user/views/home", "slider.html.erb")
        slider_content = File.read(slider_path)
        create_file "#{MAIN_PATH}/home/_slider.html.erb", <<~EOF
          #{slider_content}
        EOF

        product_path = File.join(__dir__, "templates/user/views/home", "product.html.erb")
        product_content = File.read(product_path)
        create_file "#{MAIN_PATH}/home/_product.html.erb", <<~EOF
          #{product_content}
        EOF

        # Product Show
        products_show_path = File.join(__dir__, "templates/user/views/products", "show.html.erb")
        products_show_content = File.read(products_show_path)
        create_file "#{MAIN_PATH}/products/show.html.erb", <<~EOF
          #{products_show_content}
        EOF

        products_splider_path = File.join(__dir__, "templates/user/views/products", "product_slider.html.erb")
        products_splider_content = File.read(products_splider_path)
        create_file "#{MAIN_PATH}/products/_product_slider.html.erb", <<~EOF
          #{products_splider_content}
        EOF

        size_path = File.join(__dir__, "templates/user/views/products", "size.html.erb")
        size_content = File.read(size_path)
        create_file "#{MAIN_PATH}/products/_size.html.erb", <<~EOF
          #{size_content}
        EOF

        # Shared
        navbar_path = File.join(__dir__, "templates/user/views/shared", "navbar.html.erb")
        navbar_content = File.read(navbar_path)
        create_file "#{MAIN_PATH}/shared/_navbar.html.erb", <<~EOF
          #{navbar_content}
        EOF
      end

      def copy_js
        cart_js_path = File.join(__dir__, "templates/user/assets/javascript", "cart.js")
        cart_js_content = File.read(cart_js_path)
        create_file "app/javascript/shop/user/cart.js", <<~EOF
          #{cart_js_content}
        EOF

        splider_js_path = File.join(__dir__, "templates/user/assets/javascript", "splider.js")
        splider_js_content = File.read(splider_js_path)
        create_file "app/javascript/shop/user/splider.js", <<~EOF
          #{splider_js_content}
        EOF
      end

      def images
        empty_cart_path = File.join(__dir__, "templates/user/assets/images", "empty_cart.mp4")
        empty_cart_content = File.read(empty_cart_path)
        create_file "app/assets/images/empty_cart.mp4", <<~EOF
          #{empty_cart_content}
        EOF
      end
    end
  end
end
