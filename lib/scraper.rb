require_relative '../config/credentials.rb'
require_relative './listing.rb'
require 'mechanize'
require 'pry'
require 'selenium-webdriver'

class Scraper
  attr_accessor :listing
  attr_reader :agent, :chrome, :results, :keywords, :distributors

  def initialize(keywords)
    @agent = Mechanize.new
    chrome_options = Selenium::WebDriver::Chrome::Options.new
    chrome_options.add_argument('--headless')
    @chrome = Selenium::WebDriver.for :chrome, options: chrome_options
    @results = []
    @keywords = keywords
    @distributors = {
      mercadolibre: 'https://www.mercadolibre.com.mx/', cyberpuerta: 'https://www.cyberpuerta.mx/',
      pchmayoreo: 'https://www.pchmayoreo.com/', mipc: 'https://mipc.com.mx/',
      oribalstore: 'https://www.orbitalstore.mx/buscador/index.php?terms=', grupodecme: 'https://grupodecme.com',
      digitalife: 'https://www.digitalife.com.mx/', pcel: 'https://pcel.com/index.php?route=product/search',
      ddtech: 'https://ddtech.mx/', zegucom: 'https://www.zegucom.com.mx/',
      pcmig: 'https://pcmig.com.mx/', highpro: 'https://highpro.com.mx/',
      pcdigital: 'https://www.pcdigital.com.mx/', intercompras: 'https://intercompras.com/', amazon: 'https://www.amazon.com.mx/'
    }
  end

  def search
    amazon
    mercadolibre
    cyberpuerta
    pchmayoreo
    mipc
    orbitalstore
    grupodecme
    digitalife
    pcel
    ddtech
    zegucom
    pcmig
    highpro
    pcdigital
    intercompras
  end

  def amazon
    results_before_search = @results.size
    @chrome.navigate.to distributors[:amazon]
    input = @chrome.find_element(name: 'field-keywords')
    input.send_keys @keywords
    input.submit
    @chrome.find_elements(class: 's-result-item').each do |item|
      begin
        @results << Product.new(item.find_element(class: 'a-text-normal').text,
                                item.find_element(class: 'a-price').text,
                                item.find_element(class: 'a-text-normal').attribute('href'))
      rescue Selenium::WebDriver::Error::NoSuchElementError
        next
      end
    end
    @results.size > results_before_search
  end

  def mercadolibre
    results_before_search = @results.size
    webpage = @agent.get(distributors[:mercadolibre])
    webpage.forms.first.as_word = @keywords
    results_page = webpage.forms.first.submit
    results_page.css('div.ui-search-result__wrapper').each do |item|
      @results << Product.new(item.css('h2.ui-search-item__title').text,
                              item.css('span.ui-search-price__part').first.text,
                              item.css('a').first['href'])
    end
    @results.size > results_before_search
  end

  def cyberpuerta
    results_before_search = @results.size
    webpage = @agent.get(distributors[:cyberpuerta])
    webpage.form('search').searchparam = @keywords
    results_page = webpage.form('search').submit
    results_page.css('div.emproduct').each do |item|
      @results << Product.new(item.css('a.emproduct_right_title').text,
                              item.css('label.price').text,
                              item.css('a.emproduct_right_title').first['href'])
    end
    @results.size > results_before_search
  end

  def pchmayoreo
    results_before_search = @results.size
    webpage = @agent.get(distributors[:pchmayoreo])
    login_page = webpage.link_with(text: 'Iniciar Sesión').click
    login_form = login_page.form_with(id: 'login-form')
    login_form.field_with(id: 'email').value = ENV['pch_user_id']
    login_form.field_with(id: 'pass').value = ENV['pch_pass_key']
    client_homepage = login_form.submit
    search_form = client_homepage.form_with(id: 'search_mini_form')
    search_form.q = @keywords
    results_page = agent.submit(search_form)
    results_page.css('div.item-inner').each do |item|
      @results << Product.new(item.css('h2.product-name').text,
                              item.css('span.price').first.text,
                              item.css('h2.product-name a').first['href'])
    end
    @results.size > results_before_search
  end

  def mipc
    results_before_search = @results.size
    webpage = @agent.get(distributors[:mipc])
    webpage.form_with(id: 'search_mini_form').q = @keywords
    results_page = webpage.form_with(id: 'search_mini_form').submit
    results_page.css('li.product-item').each do |item|
      @results << Product.new(item.css('h5.product-item-name').text,
                              item.at('[data-price-type="finalPrice"]').text,
                              item.css('a.product-item-link').first['href'])
    end
    @results.size > results_before_search
  end

  def orbitalstore
    results_before_search = @results.size
    results_page = @agent.get(distributors[:oribalstore] + @keywords)
    results_page.css('div.item').each do |item|
      @results << Product.new(item.css('a.title').text,
                              item.css('div.played').text,
                              item.css('a.title').first['href'])
    end
    @results.size > results_before_search
  end

  def grupodecme
    results_before_search = @results.size
    webpage = @agent.get(distributors[:grupodecme])
    webpage.forms.first.q = @keywords
    results_page = webpage.forms.first.submit
    results_page.css('a.product-grid-item').each do |item|
      @results << Product.new(item.css('p').text,
                              item.css('span.visually-hidden')[1].text,
                              (distributors[:grupodecme] + item['href']))
    end
    @results.size > results_before_search
  end

  def digitalife
    results_before_search = @results.size
    webpage = @agent.get(distributors[:digitalife])
    webpage.form_with(class: 'buscador form-inline text-center').term = @keywords
    results_page = webpage.form_with(class: 'buscador form-inline text-center').submit
    results_page.css('div.productoInfoBloq').each do |item|
      @results << Product.new(item.css('span.tituloHighlight').text,
                              item.css('div.precioFlag').text,
                              item.css('a').first['href'])
    end
    @results.size > results_before_search
  end

  def pcel
    results_before_search = @results.size
    @chrome.navigate.to distributors[:pcel]
    input = @chrome.find_element(name: 'filter_name')
    input.send_keys @keywords
    chrome.find_element(class: 'button-search').click
    results_page = @agent.get(@chrome.current_url)
    results_page.css('tr').each do |item|
      next if item.css('div.name').empty?

      @results << Product.new(item.css('div.name').text,
                              item.css('span.price-new').text,
                              item.css('div.name a').first['href'])
    end
    @results.size > results_before_search
  end

  def ddtech
    results_before_search = @results.size
    webpage = @agent.get(distributors[:ddtech])
    webpage.forms.first.search = @keywords
    results_page = webpage.forms.first.submit
    results_page.css('div.item').each do |item|
      @results << Product.new(item.css('a').text,
                              item.css('span.price').text,
                              item.css('a').first['href'])
    end
    @results.size > results_before_search
  end

  def zegucom
    results_before_search = @results.size
    webpage = @agent.get(distributors[:zegucom])
    webpage.forms.first.cons = @keywords
    results_page = webpage.forms.first.submit
    results_page.css('div.search-result').each do |item|
      @results << Product.new(item.css('div.result-description a').text,
                              item.css('span.result-price-search').text,
                              (distributors[:zegucom] + item.css('a')[1]['href']))
    end
    @results.size > results_before_search
  end

  def pcmig
    results_before_search = @results.size
    webpage = @agent.get(distributors[:pcmig])
    webpage.forms.first.s = @keywords
    results_page = webpage.forms.first.submit
    results_page.css('div.product-wrapper').each do |item|
      @results << Product.new(item.css('h2.product-name').first.text,
                              item.css('span.woocommerce-Price-amount').first.text,
                              item.css('a').first['href'])
    end
    @results.size > results_before_search
  end

  def highpro
    results_before_search = @results.size
    webpage = @agent.get(distributors[:highpro])
    webpage.form_with(id: 'searchbox').search_query = @keywords
    results_page = webpage.form_with(id: 'searchbox').submit
    results_page.css('div.product-container').each do |item|
      @results << Product.new(item.css('h5.product-title-item').text,
                              item.css('div.product-price-and-shipping').text,
                              item.css('a').first['href'])
    end
    @results.size > results_before_search
  end

  def pcdigital
    results_before_search = @results.size
    @chrome.navigate.to distributors[:pcdigital]
    input = @chrome.find_element(name: 'search')
    input.send_keys @keywords
    @chrome.find_element(class: 'button-search').click
    results_page = agent.get(@chrome.current_url)
    results_page.css('div.product').each do |item|
      @results << Product.new(item.css('div.name').text,
                              item.css('span.price-new').text,
                              item.css('div.name a').first['href'])
    end
    @results.size > results_before_search
  end

  def intercompras
    results_before_search = @results.size
    webpage = @agent.get(distributors[:intercompras])
    webpage.forms.first.keywords = @keywords
    results_page = webpage.forms.first.submit
    results_page.css('div.divContentProductInfo').each do |item|
      @results << Product.new(item.css('a.spanProductListInfoTitle').text,
                              item.css('div.divProductListPrice').text,
                              item.css('a').first['href'])
    end
    @results.size > results_before_search
  end

  def show_distributors
    @distributors
  end

  def create_listing
    @listing = Listing.new(@results)
  end
end

scraping_test = Scraper.new('RAM 16GB')
scraping_test.search
