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

  def login_as_admin

    visit root_path

    email = 'ftquixada@gmail.com'

     fill_in 'E-mail', :with => email
     fill_in 'Senha', :with => 'fulano0123'
     check 'Manter-me logado'

     click_on 'Login'
  end

  def login_as_common_user
    
    visit root_path

   email = 'renata.sbq@gmail.com'

    fill_in 'E-mail', :with => email
    fill_in 'Senha', :with => '4453566486'
    check 'Manter-me logado'

    click_on 'Login'
  end

  def assert_success_message_displayed
  end

end
