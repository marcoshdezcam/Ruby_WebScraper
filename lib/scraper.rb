# rubocop: disable Metrics/ClassLength
require_relative './listing.rb'
require 'csv'
require 'mechanize'
require 'selenium-webdriver'

class Scraper
  attr_reader :agent, :chrome, :keywords, :distributors, :listing, :results_register

  def initialize(keywords)
    @agent = Mechanize.new
    chrome_options = Selenium::WebDriver::Chrome::Options.new
    chrome_options.add_argument('--headless')
    @chrome = Selenium::WebDriver.for :chrome, options: chrome_options
    @listing = Listing.new
    @keywords = keywords
    @distributors = {
      amazon: 'https://www.amazon.com.mx/', mercadolibre: 'https://www.mercadolibre.com.mx/',
      cyberpuerta: 'https://www.cyberpuerta.mx/', digitalife: 'https://www.digitalife.com.mx/',
      grupodecme: 'https://grupodecme.com', mipc: 'https://mipc.com.mx/',
      oribalstore: 'https://www.orbitalstore.mx/buscador/index.php?terms=', pcel: 'https://pcel.com/index.php?route=product/search',
      zegucom: 'https://www.zegucom.com.mx/', pcmig: 'https://pcmig.com.mx/',
      highpro: 'https://highpro.com.mx/', pcdigital: 'https://www.pcdigital.com.mx/',
      intercompras: 'https://intercompras.com/'
    }
    @results_register = { amazon: '', mercadolibre: '', cyberpuerta: '',
                          digitalife: '', grupodecme: '', mipc: '',
                          orbitalstore: '', pcel: '', zegucom: '',
                          pcmig: '', highpro: '', pcdigital: '',
                          intercompras: '' }
  end

  def search
    amazon
    mercadolibre
    cyberpuerta
    digitalife
    grupodecme
    mipc
    orbitalstore
    pcel
    zegucom
    pcmig
    highpro
    pcdigital
    intercompras
  end

  def create_csv(filename)
    CSV.open(filename + '.csv', 'w+') do |row|
      row << ['Cheapest products found']
      row << %w[Name Price URL]
      @listing.cheapest_products.size.times do |i|
        row << [@listing.cheapest_products[i].name,
                @listing.cheapest_products[i].price,
                @listing.cheapest_products[i].url]
      end
      row << ['']
      row << ['All results found ordered by price']
      row << %w[Name Price URL]
      @listing.products.size.times do |i|
        row << [@listing.products[i].name,
                @listing.products[i].price,
                @listing.products[i].url]
      end
    end
  end

  private

  def amazon
    results_before_search = @listing.products.size
    @chrome.navigate.to distributors[:amazon]
    input = @chrome.find_element(name: 'field-keywords')
    input.send_keys @keywords
    input.submit
    @chrome.find_elements(class: 's-result-item').each do |item|
      begin
        @listing.products << Product.new(item.find_element(class: 'a-text-normal').text,
                                         item.find_element(class: 'a-price').text,
                                         item.find_element(class: 'a-text-normal').attribute('href'))
      rescue Selenium::WebDriver::Error::NoSuchElementError
        next
      end
    end
    @results_register[:amazon] = @listing.products.size > results_before_search
  end

  def mercadolibre
    results_before_search = @listing.products.size
    webpage = @agent.get(distributors[:mercadolibre])
    webpage.forms.first.as_word = @keywords
    results_page = webpage.forms.first.submit
    results_page.css('div.ui-search-result__wrapper').each do |item|
      @listing.products << Product.new(item.css('h2.ui-search-item__title').text,
                                       item.css('span.ui-search-price__part').first.text,
                                       item.css('a').first['href'])
    end
    @results_register[:mercadolibre] = @listing.products.size > results_before_search
  end

  def cyberpuerta
    results_before_search = @listing.products.size
    webpage = @agent.get(distributors[:cyberpuerta])
    webpage.form('search').searchparam = @keywords
    results_page = webpage.form('search').submit
    results_page.css('div.emproduct').each do |item|
      @listing.products << Product.new(item.css('a.emproduct_right_title').text,
                                       item.css('label.price').text,
                                       item.css('a.emproduct_right_title').first['href'])
    end
    @results_register[:cyberpuerta] = @listing.products.size > results_before_search
  end

  def mipc
    results_before_search = @listing.products.size
    webpage = @agent.get(distributors[:mipc])
    webpage.form_with(id: 'search_mini_form').q = @keywords
    results_page = webpage.form_with(id: 'search_mini_form').submit
    results_page.css('li.product-item').each do |item|
      @listing.products << Product.new(item.css('h5.product-item-name').text,
                                       item.at('[data-price-type="finalPrice"]').text,
                                       item.css('a.product-item-link').first['href'])
    end
    @results_register[:mipc] = @listing.products.size > results_before_search
  end

  def orbitalstore
    results_before_search = @listing.products.size
    results_page = @agent.get(distributors[:oribalstore] + @keywords)
    results_page.css('div.item').each do |item|
      @listing.products << Product.new(item.css('a.title').text,
                                       item.css('div.played').text,
                                       item.css('a.title').first['href'])
    end
    @results_register[:orbitalstore] = @listing.products.size > results_before_search
  end

  def grupodecme
    results_before_search = @listing.products.size
    webpage = @agent.get(distributors[:grupodecme])
    webpage.forms.first.q = @keywords
    results_page = webpage.forms.first.submit
    results_page.css('a.product-grid-item').each do |item|
      @listing.products << Product.new(item.css('p').text,
                                       item.css('span.visually-hidden')[1].text,
                                       (distributors[:grupodecme] + item['href']))
    end
    @results_register[:grupodecme] = @listing.products.size > results_before_search
  end

  def digitalife
    results_before_search = @listing.products.size
    webpage = @agent.get(distributors[:digitalife])
    webpage.form_with(class: 'buscador form-inline text-center').term = @keywords
    results_page = webpage.form_with(class: 'buscador form-inline text-center').submit
    results_page.css('div.productoInfoBloq').each do |item|
      @listing.products << Product.new(item.css('span.tituloHighlight').text,
                                       item.css('div.precioFlag').text,
                                       item.css('a').first['href'])
    end
    @results_register[:digitalife] = @listing.products.size > results_before_search
  end

  def pcel
    results_before_search = @listing.products.size
    @chrome.navigate.to distributors[:pcel]
    input = @chrome.find_element(name: 'filter_name')
    input.send_keys @keywords
    chrome.find_element(class: 'button-search').click
    results_page = @agent.get(@chrome.current_url)
    results_page.css('tr').each do |item|
      next if item.css('div.name').empty?

      @listing.products << Product.new(item.css('div.name').text,
                                       item.css('span.price-new').text,
                                       item.css('div.name a').first['href'])
    end
    @results_register[:pcel] = @listing.products.size > results_before_search
  end

  def zegucom
    results_before_search = @listing.products.size
    webpage = @agent.get(distributors[:zegucom])
    webpage.forms.first.cons = @keywords
    results_page = webpage.forms.first.submit
    results_page.css('div.search-result').each do |item|
      @listing.products << Product.new(item.css('div.result-description a').text,
                                       item.css('span.result-price-search').text[0...10],
                                       (distributors[:zegucom] + item.css('a')[1]['href']))
    end
    @results_register[:zegucom] = @listing.products.size > results_before_search
  end

  def pcmig
    results_before_search = @listing.products.size
    webpage = @agent.get(distributors[:pcmig])
    webpage.forms.first.s = @keywords
    results_page = webpage.forms.first.submit
    results_page.css('div.product-wrapper').each do |item|
      @listing.products << Product.new(item.css('h2.product-name').first.text,
                                       item.css('span.woocommerce-Price-amount').first.text,
                                       item.css('a').first['href'])
    end
    @results_register[:pcmig] = @listing.products.size > results_before_search
  end

  def highpro
    results_before_search = @listing.products.size
    webpage = @agent.get(distributors[:highpro])
    webpage.form_with(id: 'searchbox').search_query = @keywords
    results_page = webpage.form_with(id: 'searchbox').submit
    results_page.css('div.product-container').each do |item|
      @listing.products << Product.new(item.css('h5.product-title-item').text,
                                       item.css('div.product-price-and-shipping').text,
                                       item.css('a').first['href'])
    end
    @results_register[:highpro] = @listing.products.size > results_before_search
  end

  def pcdigital
    results_before_search = @listing.products.size
    @chrome.navigate.to distributors[:pcdigital]
    input = @chrome.find_element(name: 'search')
    input.send_keys @keywords
    @chrome.find_element(class: 'button-search').click
    results_page = agent.get(@chrome.current_url)
    results_page.css('div.product').each do |item|
      @listing.products << Product.new(item.css('div.name').text,
                                       item.css('span.price-new').text,
                                       item.css('div.name a').first['href'])
    end
    @results_register[:pcdigital] = @listing.products.size > results_before_search
  end

  def intercompras
    results_before_search = @listing.products.size
    webpage = @agent.get(distributors[:intercompras])
    webpage.forms.first.keywords = @keywords
    results_page = webpage.forms.first.submit
    results_page.css('div.divContentProductInfo').each do |item|
      @listing.products << Product.new(item.css('a.spanProductListInfoTitle').text,
                                       item.css('div.divProductListPrice').text,
                                       item.css('a').first['href'])
    end
    @results_register[:intercompras] = @listing.products.size > results_before_search
  end
end
# rubocop: enable Metrics/ClassLength
