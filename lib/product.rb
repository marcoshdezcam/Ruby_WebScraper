class Product
  attr_reader :name, :price, :url

  def initialize(name, price, url)
    @name = name
    @price = price
    @url = url
  end
end
