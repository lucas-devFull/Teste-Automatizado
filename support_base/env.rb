require 'capybara';
require 'capybara/cucumber';
require 'selenium-webdriver';
require 'site_prism'
require 'rspec';
require_relative 'helper.rb'
require_relative 'page_helper.rb'
require_relative 'hooks.rb'
require_relative 'downloads.rb'

    AMBIENTE = ENV['ambiente']
    CONFIG = carregandoYML(AMBIENTE)
    # CONFIG = YAML.load_file(File.dirname(__FILE__) + "/ambiente/#{AMBIENTE}.yml")

    World(ClassesParaInstanciar)
    World(DownloadHelpers)
    
Capybara.configure do |config|
    config.default_driver = :selenium_chrome
    config.app_host = CONFIG['url_login']
    Capybara.default_max_wait_time = 10
end

Capybara.register_driver :chrome do |app|
    profile = Selenium::WebDriver::Chrome::Profile.new
    profile["download.default_directory"] = DownloadHelpers::PATH.to_s
    Capybara::Selenium::Driver.new(app, :browser => :chrome, :profile => profile)
  end
  
  Capybara.default_driver = Capybara.javascript_driver = :chrome
  Capybara.javascript_driver = :webkit