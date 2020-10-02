require_relative '../lib/product.rb'

describe Product do
  describe %(#initialize) do
    let(:product) { Product.new('Kingston RAM 8GB', '$899', 'www.mercadolibre.com') }
    it %(Creates each product with a name, price & URL) do
      specify { expect(product).to exist }
    end
  end
end
