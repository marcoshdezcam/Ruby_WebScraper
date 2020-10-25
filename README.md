# Web scraper for PC Hardware prices

> This is a simple web scraper to search for the best price of PC Hardware parts on websites that sell and ship to México.

It works by searching for specific keywords of PC Hardware on the biggest México's websites. Then, it will show the best matches with the lowest prices available.
Mechanize with Nokogiri as dependency was used to fill search forms. And, Selenium to scrape websites (like Amazon) that require a real browser to visit their shop.

This is the list of distributors: 

	- MercadoLibre.com.mx
	- Cyberpuerta.mx
	- MiPC.com.mx
	- Orbitalstore.mx
	- Grupodecme.com
	- Dimercom.mx
	- Digitalife.com.mx
	- PCel.com
	- Zegucom.com.mx
	- PCMig.com.mx
	- HighPro.com.mx
	- PCDigital.com.mx
	- Intercompras.com


## 🔧 Built With

- Ruby
- Gitflow workflow
- [Mechanize](https://github.com/sparklemotion/mechanize) 	* Includes Nokogiri as dependency
- [RSpec](https://rspec.info/)
- [Selenium Webdriver](https://github.com/SeleniumHQ/selenium/tree/trunk/rb)
- [Simplecov](https://github.com/simplecov-ruby/simplecov)

<img align="left" width="50" height="50" src="./img/icon.png" alt="UML Icon" border="0">

## UML
![UML_Classes](./img/UML_Classes.png)

## 🛠  Getting Started

To get a local copy up and running follow these simple example steps.

### Prerequisites
Depending on your distribution and, therefore your package manager, this commands may change. Here, Ubuntu is used as an example. 

##### ChromeDriver (required by Selenium WebDriver)
		 
	sudo apt-get install chromium-chromedriver

##### Install gcc compiler (required by Mechanize dependencies)
		
	sudo apt install build-essential

##### Ruby

Install libraries and dependencies:

	sudo apt install gcc make libssl-dev libreadline-dev zlib1g-dev libsqlite3-dev

Install rbenv
		
	git clone https://github.com/rbenv/rbenv.git ~/.rbenv

Add rbemv to your PATH

	echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
	echo 'eval "$(rbenv init -)"' >> ~/.bashrc
	exit

After the last step you need to open a new terminal to load the new PATH variables and run: 

	mkdir -p "$(rbenv root)"/plugins
	git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build

Finally, to make sure rbenv is installed, run:

	rbenv -v
		
Install Ruby

	rbenv install 2.7.0 --verbose

Verify everything is working and set global Ruby version as 2.7.0

	rbenv global 2.7.0

Verify Ruby version

	ruby -v

### Setup
####Install required gems for this project
This command will install Mechanize, Selenium WebDriver, Rspec, Rubocop and Simplecov gems:

	bundle install

### Usage
Include the following line at the top of your file:

	require './lib/scraper.rb'

Using 'RAM 16GB' as a search example. Run the scraper with the following: 

	web_scraper = Scraper.new('RAM 16GB')
	web_scraper.search

All search results will be saved on Scraper.Listing.products

	web_scraper.listing.products

Show the 30 cheapest products found:
		
	web_scraper.listing.find_cheapest


### Run tests
To run the tests just use the following command:

	rspec

#### Simplecov report:

![Test report](./img/test_report.png)

## ✒️ Author

👤 **Marcos Hernández Campos**

- Github: [@marcoshdezcam](https://github.com/marcoshdezcam)
- Twitter: [@MarcosHCampos](https://twitter.com/MarcosHCampos)
- Linkedin: [Marcos Hernández](https://linkedin.com/marcos-hernández-56058119a/)

## 🤝 Contributing

Contributions, issues and feature requests are welcome!

Feel free to check the [issues page](issues/).

## Show your support

Give a ⭐️ if you like this project!

## Acknowledgments

- Hat tip to anyone whose code was used
- Inspiration
- etc

## 📝 License

This project is [MIT](lic.url) licensed.
