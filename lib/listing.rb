require_relative './product.rb'

class Listing
  attr_reader :products

  def initialize
    @products = []
  end

  def find_cheapest
    remove_wrong_results
    @products.sort_by!(&:price)
    @products[0...30]
  end

  private

  def remove_wrong_results
    @products.delete_if { |product| product.price.empty? }
  end
end
