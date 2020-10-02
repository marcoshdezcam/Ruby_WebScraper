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

  def search; end

  def mercadolibre; end

  def cyberpuerta; end

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
