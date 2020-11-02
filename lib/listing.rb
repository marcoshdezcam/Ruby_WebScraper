require_relative './product.rb'

class Listing
  attr_reader :products, :cheapest_products

  def initialize
    @products = []
    @cheapest_products = []
  end

  def find_cheapest
    remove_wrong_results
    @products.sort_by!(&:price)
    @cheapest_products = @products[0...30]
  end

  private

  def remove_wrong_results
    @products.delete_if { |product| product.price.empty? }
  end
end
