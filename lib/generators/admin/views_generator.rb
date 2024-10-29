require "rails/generators"
require "rails/generators/migration"

module Admin
  module Generators
    class ViewsGenerator < Rails::Generators::Base
      include Rails::Generators::Migration
      source_root File.expand_path("templates/admin", __dir__)

      # Generate Layouts
      def create_layout_file
        create_file "app/views/layouts/shop_admin.html.erb", <<~EOF
          <!DOCTYPE html>
          <html>
            <head>
              <title>Admin Shop</title>
              <%= csrf_meta_tags %>
              <%= csp_meta_tag %>
              <%= stylesheet_link_tag "application", "data-turbo-track": "reload" %>
              <meta name="viewport" content="width=device-width,initial-scale=1">
              <script src="https://cdn.tailwindcss.com"></script>
              <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
            </head>
            <body>
              <%= yield %>
            </body>
          </html>
        EOF
      end

      # Copying view templates
      def copy_views
        index_path = File.join(__dir__, "templates/admin/views/shops", "index.html.erb")
        index_content = File.read(index_path)
        create_file "app/views/admin/shops/index.html.erb", <<~EOF
          #{index_content}
        EOF
        template "views/shops/new.html.erb", "app/views/admin/shops/new.html.erb"
        template "views/shared/field_loader.html.erb", "app/views/admin/shared/_field_loader.html.erb"
        submit_btn_path = File.join(__dir__, "templates/admin/views/shared", "submit_button.html.erb")
        submit_content = File.read(submit_btn_path)
        create_file "app/views/admin/shared/_submit_button.html.erb", <<~EOF
          #{submit_content}
        EOF
        template "views/shared/success_svg.html.erb", "app/views/admin/shared/_success_svg.html.erb"
        template "views/dashboard/index.html.erb", "app/views/admin/dashboard/index.html.erb"
      end
    end
  end
end
