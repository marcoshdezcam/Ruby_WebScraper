require_relative '../lib/scraper.rb'

describe Scraper do
  context %(Intial Scraper distributors data) do
    it %(has a hash with the initial distributors data) do
      scraper = Scraper.new('CPU')
      expect(scraper.distributors).to be_instance_of(Hash)
    end
  end
  context %(When the Scraper is created, it should have keywords asigned.) do
    it %(has keywords to search) do
      scraper = Scraper.new('RAM 8GB')
      expect(scraper.keywords.empty?).to be false
    end
  end
  context %(When a search is done) do
    it %( creates a Mechanize object on the results variable) do
      scraper = Scraper.new('RAM 8GB')
      scraper.search
      expect(scraper.results).to be_instance_of(Mechanize)
    end
  end
end
