require 'mechanize'
require 'pry'

class Scraper
  attr_reader :results, :keywords, :distributors

  def initialize(keywords)
    @results = []
    @keywords = keywords
    @distributors = {
      mercadolibre: 'https://www.mercadolibre.com.mx/',
      cyberpuerta: 'https://www.cyberpuerta.mx/',
      pchmayoreo: 'https://www.pchmayoreo.com/',
      mipc: 'https://mipc.com.mx/',
      oribalstore: 'https://www.orbitalstore.mx/',
      grupodecme: 'https://grupodecme.com/',
      digitalife: 'https://www.digitalife.com.mx/',
      pcel: 'https://pcel.com/',
      ddtech: 'https://ddtech.mx/',
      zegucom: 'https://www.zegucom.com.mx/',
      pcmig: 'https://pcmig.com.mx/',
      highpro: 'https://highpro.com.mx/',
      pcdigital: 'https://www.pcdigital.com.mx/',
      intercompras: 'https://intercompras.com/'
    }
  end

  def search
    mercadolibre
    cyberpuerta
  end

  def mercadolibre
    agent = Mechanize.new
    models = []
    prices = []
    urls = []
    webpage = agent.get(distributors[:mercadolibre])
    search_form = webpage.forms.first
    search_form.as_word = @keywords
    results_page = agent.submit(search_form)
    results_page.css('div.ui-search-result__wrapper').each do |item|
      models << item.css('h2.ui-search-item__title').text
      prices << item.css('span.ui-search-price__part').first.text
      urls << item.css('a').first['href']
    end
    products = models.zip(prices, urls)
    @results << products
    products.empty? ? false : true
  end

  def cyberpuerta
    agent = Mechanize.new
    models = []
    prices = []
    urls = []
    webpage = agent.get(distributors[:cyberpuerta])
    search_form = webpage.form('search')
    search_form.searchparam = @keywords
    results_page = agent.submit(search_form)
    results_page.css('div.emproduct').each do |item|
      models << item.css('a.emproduct_right_title').text
      prices << item.css('label.price').text
      urls << item.css('a.emproduct_right_title').first['href']
    end
    products = models.zip(prices, urls)
    @results << products
    products.empty? ? false : true
  end

  def pchmayoreo; end

  def mipc; end

  def orbitalstore; end

  def grupodecme; end

  def digitalife; end

  def pcel; end

  def ddtech; end

  def zegucom; end

  def pcmig; end

  def highpro; end

  def pcdigital; end

  def intercompras; end

  def show_distributors; end

  def create_listing; end
end

scraping_test = Scraper.new('RAM 8GB')
scraping_test.search
