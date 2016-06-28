$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../pages')
# require 'capybara/cucumber'
# require 'appium_capybara'
require 'appium_lib'
require 'rspec/expectations'
require 'cucumber/ast'
require 'rspec'
include RSpec::Matchers

ENV['password'] ||= 'Auth3nt1c'
#
ENV['APP_HOST'] ||= "apidev.aconex.com"

ENV['Location'] ||= 'Other'


# Create a custom World class so we don't pollute `Object` with Appium methods
class AppiumWorld
end

# Load the desired configuration from appium.txt, create a driver then
# Add the methods to the world
caps = Appium.load_appium_txt file: File.expand_path('./', __FILE__), verbose: true
Appium::Driver.new(caps)
Appium.promote_appium_methods AppiumWorld

World do
  AppiumWorld.new
end

Before { $driver.start_driver }
After { $driver.driver_quit }