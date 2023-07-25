# frozen_string_literal: true

require 'rexml/document'

class Product
  attr_accessor :cost, :amount, :name

  def self.add_product(dir_path)
    file = File.new(dir_path)
    doc = REXML::Document.new(file)
    file.close
    line = nil
    while line != '3'
      puts 'Создать книгу - 1, Создать фильм - 2 Выйти - 3'
      line = gets.chomp
      case line
      when '1'
        puts 'Введите название книги:'
        title = gets.chomp
        puts 'Введите жанр книги:'
        genre = gets.chomp
        puts 'Введите автора книги:'
        author_name = gets.chomp
        puts 'Введите цену книги:'
        price = gets.chomp
        puts 'Введите количество доступных в продаже книг:'
        amount = gets.chomp
        product = doc.root.add_element('product',{'price' => price, 'amount_available' => amount})
        product.add_element('book', {'genre' => genre, 'title' => title, 'author_name' => author_name})
        file = File.new(dir_path, 'w')
        # file.puts('<?xml version="1.0" encoding="utf-8"?>')
        doc.write(file,2)
        file.close
      when '2'
        puts 'Введите название фильма:'
        title = gets.chomp
        puts 'Введите год выпуска фильма:'
        year = gets.chomp
        puts 'Введите режиссера книги:'
        director = gets.chomp
        puts 'Введите цену фильма:'
        price = gets.chomp
        puts 'Введите количество доступных в продаже фильмов:'
        amount = gets.chomp
        product = doc.root.add_element('product',{'price' => price, 'amount_available' => amount})
        product.add_element('film', {'year' => year, 'title' => title, 'author_name' => director})
        file = File.new(dir_path, 'w')
        # file.puts('<?xml version="1.0" encoding="utf-8"?>')
        doc.write(file,2)
        file.close
      when '3'
        print ''
      else
        puts 'Неверное действие'
      end
    end
  end

  def self.read_from_xml(dir_path)
    items = []
    item = nil
    file = File.new(dir_path)
    doc = REXML::Document.new(file)
    doc.elements.each('products/product') do |product|
      amount = product.attributes['amount_available']
      price = product.attributes['price']
      product.elements.each('book') do |book|
        title = book.attributes['title']
        author_name = book.attributes['author_name']
        genre = book.attributes['genre']
        item = Book.new(cost: price, name: title, amount: amount, author: author_name, genre: genre)
      end
      product.elements.each('film') do |film|
        title = film.attributes['title']
        director = film.attributes['author_name']
        year = film.attributes['year']
        item = Film.new(cost: price, name: title, amount: amount, director: director, year: year)
      end
      items.push(item)
    end
    items
  end

  def initialize(params)
    @cost = params[:cost]
    @amount = params[:amount]
    @name = params[:name]
  end

  def to_s
    " #{cost} рублей,(осталось: #{amount})"
  end

  def update(params)
    @cost = params[:cost] if params[:cost]
    @amount = params[:amount] if params[:amount]
    @name = params[:name] if params[:name]
  end

  def self.from_file
    puts 'NotImplementedError'
  end
end
