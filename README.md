# Shop

Shop is a comprehensive e-commerce solution for Rails that simplifies cart and product management. It:

* Provides seamless integration for managing carts, products, and sizes;
* Offers a fully modular system, allowing you to only use the components you need;
* Supports multiple variants and bulk operations for products and sizes;
* Easily customizable to fit different e-commerce platforms;
* Built with scalability in mind to handle various product configurations and user demands.

It's mainly composed of 5 modules:
* [**Cart**](https://www.rubydoc.info/gems/e-commerce_shop/0.1.0/Shop/Cart): Can Create, Delete or Clear cart for the user by using this module.
* [**Products**](https://www.rubydoc.info/gems/e-commerce_shop/0.1.0/Shop/Product): Can Create, Update, Delete or get specific user products by using this module.
* [**Variants**](https://www.rubydoc.info/gems/e-commerce_shop/0.1.0/Shop/Variant): Can Create, Update, Delete or get specific user variant against product by using this module.
* [**Sizes**](https://www.rubydoc.info/gems/e-commerce_shop/0.1.0/Shop/Size): Can Create Single and multiple sizes, Update, Delete sizes by using this module.
* [**CartItems**](https://www.rubydoc.info/gems/e-commerce_shop/0.1.0/Shop/CartItem): Can Create, Add, Remove, Delete Items from the cart.

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/cart_management`. To experiment with that code, run `bin/console` for an interactive prompt.

## Table of Contents
* [Information](#information)
  * [Ruby Version Compatibility](#ruby-version-compatibility)
  * [Ruby Doc Documentation](#ruby-doc-documentation)
* [Getting Started](#getting-started)
* [Usage](#usage)
  * [Cart](#cart)
    * [Get](#get)
    * [Create](#create)
    * [Delete](#delete)
    * [Clear](#clear)
  * [Products](#products)
    * [Get](#get-1)
    * [Create](#create-1)
    * [Update](#update)
    * [Delete](#delete-1)
  * [Variants](#variants)
    * [Get](#get-2)
    * [Create](#create-2)
    * [Update](#update-1)
    * [Delete](#delete-2)
  * [Sizes]()
  * [CartItems]()

## Information

### Ruby Version Compatibility
This shop gem supports ruby version that are ">= 2.6.0".

### Ruby Doc Documentation
You can view the Devise documentation in RDoc format here:

https://www.rubydoc.info/gems/e-commerce_shop/0.1.0/Shop

## Getting Started
For Using this gem you need to install gem by adding this line in Gemfile

    $ gem 'shop', '~> 0.1.0'

or you can directly add gem from terminal by using this command

    $ bundle add shop

or you can directly install gem using

    $ gem install shop

After installing gem. Run this command to get all the migrations and models for this gem

    $ rails generate shop:install

After running this command you can run `rails db:migrate` for all the migrations to be added in db.

## Usage

### Cart

Response for all these methods will be in the json format. For Example

    $ { message: 'Cart Found Successfully', cart: Cart, status: :found }

#### Get

To get the specific user cart access the cart module with this method

    $ Shop::Cart.new(USER_ID).specific_user_cart

#### Create

You need to initialize an object using the specific user id for which you are creating a cart. For Example

    $ Shop::Cart.new(USER_ID).create

This will create the cart for the specific user.

#### Delete

For Deleting the cart you need to call the delete method.

    $ Shop::Cart.new(USER_ID).delete

#### Clear

For Deleting the cart you need to call the delete method.

    $ Shop::Cart.new(USER_ID).clear

### Products

Response for all these methods will be in the json format. For Example

    $ { message: 'Products Found Successfully', product: Product, status: :found }

#### Get

To get the specific user products access the Product module with this method `specific_user_products` with two extra
params.

`order (:asc | :desc)`: This will order the created products by ascending or descending order
`q (String | nil)`: This will search the product by its name and country

    $ Shop::Product.new(USER_ID).specific_user_products(:asc, nil)

#### Create

You need to initialize an object using the specific user id for which you are creating a product by sending the
product params.

**Supported Params**

| param        | value       |
|--------------|-------------|
| name         | String      |
| price        | Float       |
| description  | String, Nil |
| delivery_fee | Float, Nil  |
| country      | String, Nil |


    $ Shop::Product.new(USER_ID).create(name, price, description, delivery_fee, country)

This will create the Product for the user this module was initialized.

#### Update
For Updating the product you need to call the update method for Product module with params.

**Supported Params**

| params       | value            | Example                                                                 |
|--------------|------------------|-------------------------------------------------------------------------|
| product_hash | Hash[key, value] | {name: 'first product update', other params for product to update ....} |
| product_id   | Integer          | Id for the product to update                                            |

    $ Shop::Product.new(USER_ID).update(product_hash, product_id)

#### Delete

For Deleting the product just provide the product id and call the delete method.

    $ Shop::Product.new(USER_ID).delete(product_id)


### Variants

Response for all these methods will be in the json format. For Example

    $ { message: 'Variants Found Successfully', variants: Variant, status: :found }

#### Get

To get the specific product variants access the Variant module with this method `specific_product_variants` with three extra params.

`product_id (Integer)`: This is the id of the product against you want to search for variants.
`order (:asc | :desc)`: This will order the created products by ascending or descending order
`q (String | nil)`: This will search the product by its name and country

    $ Shop::Variant.new.specific_product_variants(1, :asc, nil)

#### Create

For Creation of Variant access the Variant module with this method `create` with three extra params

**Supported Params**

| param        | value       |
|--------------|-------------|
| product_id   | Integer     |
| name         | String      |
| color        | String      |

    $ Shop::Variant.new.create(product_id, name, color)

This will create the Variant for the product.

#### Update
For Updating the variant you need to call the update method for Variant module with params.

**Supported Params**

| params       | value            | Example                                                                         |
|--------------|------------------|---------------------------------------------------------------------------------|
| variant_id   | Integer          | Id for the Variant to update                                                    |
| variant_hash | Hash[key, value] | {name: 'first product variant update', other params for product to update ....} |

    $ Shop::Variant.new.update(product_id, variant_hash)

#### Delete

For Deleting the Variant just provide the Variant id and call the delete method.

    $ Shop::Variant.new.delete(variant_id)


## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/cart_management. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/cart_management/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the CartManagement project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/cart_management/blob/main/CODE_OF_CONDUCT.md).
