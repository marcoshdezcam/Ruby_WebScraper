require_relative './product.rb'

class Listing
  attr_reader :products

  def initialize(results)
    no_results = results[0].size - 1
    @products = []
    i = 1
    no_results.times do
      @products << Product.new(results[0][i], results[1][i], results[2][i])
      i += 1
    end
  end
end
