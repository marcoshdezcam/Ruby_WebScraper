require_relative '../config/credentials.rb'
require 'mechanize'
require 'pry'

class Scraper
  attr_reader :agent, :results, :keywords, :distributors

  def initialize(keywords)
    @agent = Mechanize.new
    @results = [['Product name'], ['Price'], ['URL']]
    @keywords = keywords
    @distributors = {
      mercadolibre: 'https://www.mercadolibre.com.mx/',
      cyberpuerta: 'https://www.cyberpuerta.mx/',
      pchmayoreo: 'https://www.pchmayoreo.com/',
      mipc: 'https://mipc.com.mx/',
      oribalstore: 'https://www.orbitalstore.mx/buscador/index.php?terms=',
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
    mipc
    orbitalstore
  end

  def mercadolibre
    webpage = @agent.get(distributors[:mercadolibre])
    search_form = webpage.forms.first
    search_form.as_word = @keywords
    results_page = agent.submit(search_form)
    results_page.css('div.ui-search-result__wrapper').each do |item|
      @results[0] << item.css('h2.ui-search-item__title').text
      @results[1] << item.css('span.ui-search-price__part').first.text
      @results[2] << item.css('a').first['href']
    end
  end

  def cyberpuerta
    webpage = @agent.get(distributors[:cyberpuerta])
    search_form = webpage.form('search')
    search_form.searchparam = @keywords
    results_page = agent.submit(search_form)
    results_page.css('div.emproduct').each do |item|
      @results[0] << item.css('a.emproduct_right_title').text
      @results[1] << item.css('label.price').text
      @results[2] << item.css('a.emproduct_right_title').first['href']
    end
  end

  def pchmayoreo
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
      @results[0] << item.css('h2.product-name').text
      @results[1] << item.css('span.price').text
      @results[2] << item.css('h2.product-name a').first['href']
    end
  end

  def mipc
    webpage = agent.get(distributors[:mipc])
    search_form = webpage.form_with(id: 'search_mini_form')
    search_form.q = @keywords
    results_page = agent.submit(search_form)
    results_page.css('li.product-item').each do |item|
      @results[0] << item.css('h5.product-item-name').text
      @results[1] << item.at('[data-price-type="finalPrice"]').text
      @results[2] << item.css('a.product-item-link').first['href']
    end
  end

  def orbitalstore
    results_page = agent.get(distributors[:oribalstore] + @keywords)
    results_page.css('div.item').each do |item|
      @results[0] << item.css('a.title').text
      @results[1] << item.css('div.played').text
      @results[2] << item.css('a.title').first['href']
    end
  end

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
