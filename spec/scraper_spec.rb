describe Scraper do
  context %(A distributors list exists) do
    it %(has a hash with the distributors data) do
    end
  end
  context %(When the Scraper is created, it should have keywords asigned.) do
    it %(has keywords to search) do
      scraper = Scraper.new('RAM, 8GB')
      expect(scraper.keywords.empty?).to be false
    end
  end
end
