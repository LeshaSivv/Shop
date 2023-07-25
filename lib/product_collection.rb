# frozen_string_literal: true

require_relative 'product'
require_relative 'film'
require_relative 'book'

class Product_collection
  attr_accessor :collection

  PRODUCT_TYPES =
    {
      film: { dir: 'films', class: Film },
      book: { dir: 'books', class: Book }
    }.freeze

  def initialize(collection = [])
    @collection = collection
  end

  def self.from_dir(dir_path)
    collection = []
    PRODUCT_TYPES.each do |_type, hash|
      product_dir = hash[:dir]
      product_class = hash[:class]
      Dir["#{dir_path}/#{product_dir}/*.txt"].each do |path|
        collection << product_class.from_file(path)
      end
    end
    new(collection)
  end

  def to_a
    @collection
  end

  def sort_by!(by)
    case by
    when :name
      @collection.sort_by!(&:name)
    when :amount
      @collection.sort_by!(&:amount)
    when :cost
      @collection.sort_by!(&:cost)
    else
      puts 'Нет такого вида сортировки'
    end
  end
end
