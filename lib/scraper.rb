require_relative '../config/credentials.rb'
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
    pchmayoreo
    binding.pry
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

  def pchmayoreo
    agent = Mechanize.new
    models = []
    prices = []
    urls = []
    webpage = agent.get(distributors[:pchmayoreo])
    login_page = webpage.link_with(text: 'Iniciar Sesión').click
    login_form = login_page.form_with(id: 'login-form')
    login_form.field_with(id: 'email').value = ENV['pch_user_id']
    login_form.field_with(id: 'pass').value = ENV['pch_pass_key']
    client_homepage = login_form.submit
    search_form = client_homepage.form_with(id: 'search_mini_form')
    search_form.q = @keywords
    results_page = agent.submit(search_form)
    results_page.css('div.item-inner').each do |item|
      models << item.css('h2.product-name').text
      prices << item.css('span.price').text
      urls << item.css('h2.product-name a').first['href']
    end
    products = models.zip(prices, urls)
    @results << products
    products.empty? ? false : true
  end

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
