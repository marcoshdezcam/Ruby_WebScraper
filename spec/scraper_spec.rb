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
end
