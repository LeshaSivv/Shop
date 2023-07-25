# frozen_string_literal: true

require_relative 'product'

class Film < Product
  attr_accessor :director, :year

  def initialize(params)
    super
    @director = params[:director]
    @year = params[:year]
  end

  def to_s
    "Фильм \"#{name}\",#{year} ,реж. #{director},#{super}"
  end

  def update(params)
    super
    @director = params[:director] if params[:director]
    @year = params[:year] if params[:year]
  end

  def self.from_file(path)
    file = File.new(path, 'r')
    name = file.readline.chomp
    director = file.readline.chomp
    year = file.readline.chomp
    cost = file.readline.chomp
    amount = file.readline.chomp
    new(cost: cost, amount: amount, name: name, year: year, director: director)
  end
end
