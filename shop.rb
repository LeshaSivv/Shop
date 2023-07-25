# frozen_string_literal: true

require_relative 'lib/product_collection'

current_path = File.dirname(__FILE__)

Product.add_product("#{current_path}/data/products.xml")
products = Product.read_from_xml("#{current_path}/data/products.xml")
puts products
