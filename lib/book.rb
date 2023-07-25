# frozen_string_literal: true

require_relative 'product'

class Book < Product
  attr_accessor :genre, :author

  def initialize(params)
    super
    @genre = params[:genre]
    @author = params[:author]
  end

  def to_s
    "Книга \"#{name}\",#{genre} ,автор - #{author} ,#{super}"
  end

  def update(params)
    super
    @genre = params[:genre] if params[:genre]
    @author = params[:author] if params[:author]
  end

  def self.from_file(path)
    file = File.new(path, 'r')
    name = file.readline.chomp
    genre = file.readline.chomp
    author = file.readline.chomp
    cost = file.readline.chomp
    amount = file.readline.chomp
    new(cost: cost, amount: amount, name: name, genre: genre, author: author)
  end
end
