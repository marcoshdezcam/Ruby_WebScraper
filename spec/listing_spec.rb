require_relative '../lib/scraper.rb'

describe Listing do
  let(:scraper) { Scraper.new('RAM 8GB') }
  let(:listing) { Listing.new }

  describe %(#initialize) do
    it %(creates an empty array to store the search results) do
      expect(listing.products).to be_instance_of(Array)
    end
  end
  describe %(#find_cheapest) do
    it %(returns 30 product instances with the cheapest prices) do
      scraper.search
      scraper.listing.find_cheapest
      expect(scraper.listing.cheapest_products.first).to be_instance_of(Product)
      expect(scraper.listing.cheapest_products.size).to eq(30)
    end
  end
end
