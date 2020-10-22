require_relative './product.rb'

class Listing
  attr_reader :products

  def initialize
    @products = []
  end

  def find_cheapest; end

  def show_listing
    @products
  end
end
