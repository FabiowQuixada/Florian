ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "minitest/rails/capybara"
#require 'selenium-webdriver'

class ActiveSupport::TestCase
    #load "#{Rails.root}/db/seeds.rb"

    Capybara.register_driver :selenium do |app|
   profile = Selenium::WebDriver::Firefox::Profile.new
   Capybara::Selenium::Driver.new( app, :browser => :firefox, :profile => profile )
end

    Capybara.default_driver = :selenium

# Capybara.register_driver :my_firefox_driver do |app|
#     profile = Selenium::WebDriver::Firefox::Profile.new
#     Capybara::Selenium::Driver.new(app, :browser => :firefox, :profile => profile)
#   end

  include FactoryGirl::Syntax::Methods

end
