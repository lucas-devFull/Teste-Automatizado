require 'appium_lib'
require 'appium_console'
require 'capybara';
require 'capybara/cucumber';
require 'selenium-webdriver';
require 'site_prism'
require 'rspec';
require_relative 'helper.rb'
require_relative 'helper_app.rb'
require_relative 'page_helper.rb'
require_relative 'hooks.rb'
require_relative 'downloads.rb'
require 'securerandom'
require 'fileutils'

    AMBIENTE = ENV['ambiente']
    CONFIG = carregandoYML(AMBIENTE)
    # CONFIG = YAML.load_file(File.dirname(__FILE__) + "/ambiente/#{AMBIENTE}.yml")

    World(ClassesParaInstanciar)
    World(DownloadHelpers)
    
Capybara.configure do |config|
    config.default_driver = :selenium_chrome
    config.app_host = CONFIG['url_login']
    Capybara.default_max_wait_time = 5
end

Capybara.register_driver :chrome do |app|
    profile = Selenium::WebDriver::Chrome::Profile.new
    profile["download.default_directory"] = DownloadHelpers::PATH.to_s
    Capybara::Selenium::Driver.new(app, :browser => :chrome, :profile => profile)
end

def caps
  {
    caps: {
      "platformName": "Android",
      "deviceName": "New_Device_API_26",
      "app": "/home/lucas/Área de Trabalho/TestesAutomatizados/teste_automatizado/FMobile_5.1.4.apk",
      "noReset": "true"
    }
  }
end
  
Appium::Driver.new(caps, true)
Appium.promote_appium_methods Object