class Product
  attr_reader :name, :price, :url

  def initialize(name, price, url)
    @name = clean_string(name)
    @price = remove_spaces(clean_string(price))
    @url = url
  end

  private

  def clean_string(string)
    string.tr!("\t", '')
    string.tr!("\n", ',')
    string.tr!("\r", '')
    string.strip!
    string
  end

  def remove_spaces(string)
    string.delete(' ')
  end
end
