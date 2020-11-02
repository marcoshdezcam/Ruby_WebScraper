# rubocop: disable Metrics/BlockLength
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
  context %(When searching, each distributor method returns true or false to report if there was any results) do
    it %(saves true or false to report results on Amazon) do
      expect(scraper.results_register[:amazon]).not_to be nil
    end
    it %(saves true or false to report results on Mercado Libre) do
      expect(scraper.results_register[:mercadolibre]).not_to be nil
    end
    it %(saves true or false to report results on Cyberpuerta) do
      expect(scraper.results_register[:cyberpuerta]).not_to be nil
    end
    it %(saves true or false to report results on Digitalife) do
      expect(scraper.results_register[:digitalife]).not_to be nil
    end
    it %(saves true or false to report results on Grupodecme) do
      expect(scraper.results_register[:grupodecme]).not_to be nil
    end
    it %(saves true or false to report results on MiPC) do
      expect(scraper.results_register[:mipc]).not_to be nil
    end
    it %(saves true or false to report results on Orbital Store) do
      expect(scraper.results_register[:orbitalstore]).not_to be nil
    end
    it %(saves true or false to report results on PC En Linea) do
      expect(scraper.results_register[:pcel]).not_to be nil
    end
    it %(saves true or false to report results on Zegucom) do
      expect(scraper.results_register[:zegucom]).not_to be nil
    end
    it %(saves true or false to report results on PCMig) do
      expect(scraper.results_register[:pcmig]).not_to be nil
    end
    it %(saves true or false to report results on High Pro) do
      expect(scraper.results_register[:highpro]).not_to be nil
    end
    it %(saves true or false to report results on PC Digital) do
      expect(scraper.results_register[:pcdigital]).not_to be nil
    end
    it %(saves true or false to report results on Intercompras) do
      expect(scraper.results_register[:intercompras]).not_to be nil
    end
  end
end
# rubocop: enable Metrics/BlockLength
