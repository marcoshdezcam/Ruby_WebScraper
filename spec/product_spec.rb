require_relative '../lib/product.rb'

describe Product do
  describe %(#initialize) do
    let(:product) { Product.new('Kingston RAM 8GB', '$899', 'www.mercadolibre.com') }
    it %(Assigns the parameters with the constructor correctly) do
      expect(product.name).to eq('Kingston RAM 8GB')
      expect(product.price).to eq('$899')
      expect(product.url).to eq('www.mercadolibre.com')
    end
  end
end
