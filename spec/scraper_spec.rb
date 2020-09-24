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
end
