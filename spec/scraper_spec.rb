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
  context %(When a search is done on each distributor) do
    it %(returns a boolean on mercadolibre's search, to report if results where found) do
      scraper = Scraper.new('RAM 8GB')
      expect(scraper.mercadolibre).to be(true).or be(false)
    end
    it %(returns a boolean on cyberpuerta's search, to report if results where found) do
      scraper = Scraper.new('RAM 8GB')
      expect(scraper.cyberpuerta).to be(true).or be(false)
    end
    it %(returns a boolean on pchmayoreo's search, to report if results where found) do
      scraper = Scraper.new('RAM 8GB')
      expect(scraper.pchmayoreo).to be(true).or be(false)
    end
    it %(returns a boolean on mipc's search, to report if results where found) do
      scraper = Scraper.new('RAM 8GB')
      expect(scraper.mipc).to be(true).or be(false)
    end
    it %(returns a boolean on orbitalstore's search, to report if results where found) do
      scraper = Scraper.new('RAM 8GB')
      expect(scraper.orbitalstore).to be(true).or be(false)
    end
    it %(returns a boolean on grupodecme's search, to report if results where found) do
      scraper = Scraper.new('RAM 8GB')
      expect(scraper.grupodecme).to be(true).or be(false)
    end
    it %(returns a boolean on difitalife's search, to report if results where found) do
      scraper = Scraper.new('RAM 8GB')
      expect(scraper.digitalife).to be(true).or be(false)
    end
    it %(returns a boolean on pcel's search, to report if results where found) do
      scraper = Scraper.new('RAM 8GB')
      expect(scraper.pcel).to be(true).or be(false)
    end
    it %(returns a boolean on ddtech's search, to report if results where found) do
      scraper = Scraper.new('RAM 8GB')
      expect(scraper.ddtech).to be(true).or be(false)
    end
    it %(returns a boolean on zegucom's search, to report if results where found) do
      scraper = Scraper.new('RAM 8GB')
      expect(scraper.zegucom).to be(true).or be(false)
    end
    it %(returns a boolean on pcmig's search, to report if results where found) do
      scraper = Scraper.new('RAM 8GB')
      expect(scraper.pcmig).to be(true).or be(false)
    end
    it %(returns a boolean on highpro's search, to report if results where found) do
      scraper = Scraper.new('RAM 8GB')
      expect(scraper.highpro).to be(true).or be(false)
    end
    it %(returns a boolean on pcdigital's search, to report if results where found) do
      scraper = Scraper.new('RAM 8GB')
      expect(scraper.pcdigital).to be(true).or be(false)
    end
    it %(returns a boolean on intercompra's search, to report if results where found) do
      scraper = Scraper.new('RAM 8GB')
      expect(scraper.intercompras).to be(true).or be(false)
    end
  end
end
