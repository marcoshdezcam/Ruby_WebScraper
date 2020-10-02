require_relative '../lib/listing.rb'

describe Listing do
  let(:results) do
    [
      ['Kingston 8GB', '$899', 'www.mercadolibre.com'],
      ['Adata 8GB', '$850', 'www.mercadolibre.com']
    ]
  end
  let(:listing) { Listing.new(results) }
  describe %(#initialize) do
    it %(creates an array of products with the results from the scraper) do
      expect(listing.products.first).to be_instance_of(Product)
    end
  end
  describe %(#find_cheapest) do
    it %(returns a product object) do
      expect(listing.find_cheapest).to be_instance_of(Product)
    end
    it %(returns the cheapest product) do
      cheapest = listing.find_cheapest
      expect(cheapest.price).to eq('$850')
    end
  end
end
