class Product
  attr_accessor :name, :price, :url

  def initialize(name, price, url)
    @name = clean_string(name)
    @price = clean_string(price)
    @url = url
  end

  def clean_string(string)
    string.tr!("\t", '')
    string.tr!("\n", ',')
    string.tr!("\r", '')
    string.strip!
    string
  end
end
