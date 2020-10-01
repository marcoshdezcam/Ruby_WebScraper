require_relative '../lib/scraper.rb'

describe Scraper do
  context %(When the Scraper object is created) do
    it %(has a hash with the initial distributors data) do
      scraper = Scraper.new('CPU')
      expect(scraper.distributors).to be_instance_of(Hash)
    end
    it %(has initial keywords to search) do
      scraper = Scraper.new('RAM 8GB')
      expect(scraper.keywords.empty?).to be false
    end
  end
  context %(When a search is done) do
    it %(saves the results on the instance variable results) do
      scraper = Scraper.new('RAM 8GB')
      scraper.search
      expect(scraper.results.empty?).to be false
    end
  end
  context %(When searching on each distributor, return true or false to report retults) do
    let(:scraper) { Scraper.new('RAM 8GB') }
    it { expect(scraper.mercadolibre).to be(true).or be(false) }
    it { expect(scraper.cyberpuerta).to be(true).or be(false) }
    it { expect(scraper.pchmayoreo).to be(true).or be(false) }
    it { expect(scraper.mipc).to be(true).or be(false) }
    it { expect(scraper.orbitalstore).to be(true).or be(false) }
    it { expect(scraper.grupodecme).to be(true).or be(false) }
    it { expect(scraper.digitalife).to be(true).or be(false) }
    it { expect(scraper.pcel).to be(true).or be(false) }
    it { expect(scraper.ddtech).to be(true).or be(false) }
    it { expect(scraper.zegucom).to be(true).or be(false) }
    it { expect(scraper.pcmig).to be(true).or be(false) }
    it { expect(scraper.highpro).to be(true).or be(false) }
    it { expect(scraper.pcdigital).to be(true).or be(false) }
    it { expect(scraper.intercompras).to be(true).or be(false) }
  end
  describe %(#show_distributors) do
    it %(returns the hash of distributors) do
      scraper = Scraper.new('RAM 8GB')
      expect(scraper.show_distributors).to be(scraper.distributors)
    end
  end
end
