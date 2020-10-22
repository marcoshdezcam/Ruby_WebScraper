require_relative '../lib/scraper.rb'

describe Scraper do
  let(:scraper) { Scraper.new('RAM 8GB') }
  context %(When the Scraper object is created) do
    it %(has a hash with the initial distributors data) do
      expect(scraper.distributors).to be_instance_of(Hash)
    end
    it %(has initial keywords to search) do
      expect(scraper.keywords.empty?).to be false
    end
  end
  context %(When a search is done) do
    it %(saves the results on Listing.products) do
      scraper.search
      expect(scraper.listing.products.empty?).to be false
    end
  end
  context %(When searching on each distributor, return true or false to report retults) do
    it { expect(scraper.mercadolibre).to be(true).or be(false) }
    it { expect(scraper.cyberpuerta).to be(true).or be(false) }
    it { expect(scraper.pchmayoreo).to be(true).or be(false) }
    it { expect(scraper.mipc).to be(true).or be(false) }
    it { expect(scraper.orbitalstore).to be(true).or be(false) }
    it { expect(scraper.grupodecme).to be(true).or be(false) }
    it { expect(scraper.digitalife).to be(true).or be(false) }
    it { expect(scraper.pcel).to be(true).or be(false) }
    it { expect(scraper.zegucom).to be(true).or be(false) }
    it { expect(scraper.pcmig).to be(true).or be(false) }
    it { expect(scraper.highpro).to be(true).or be(false) }
    it { expect(scraper.pcdigital).to be(true).or be(false) }
    it { expect(scraper.intercompras).to be(true).or be(false) }
  end
  describe %(#show_distributors) do
    it %(returns the hash of distributors) do
      expect(scraper.show_distributors).to be_instance_of(Hash)
    end
  end
end
