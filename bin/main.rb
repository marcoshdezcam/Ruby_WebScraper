require_relative '../lib/scraper.rb'

# Ask for search terms to the user
puts %(Enter keywords for a new search:)
keywords = gets.chomp

puts %(Type the name of the CSV file to save the results)
results_filename = gets.chomp

puts %(Searching on distributors...)
scraper_test = Scraper.new(keywords)
scraper_test.search

puts %(Finding cheapest products...)
scraper_test.listing.find_cheapest

puts %(Creating file #{results_filename}.csv)
scraper_test.create_csv(results_filename)
