require 'rubygems'

# All our specs should require 'spec_helper' (this file)

# If RACK_ENV isn't set, set it to 'test'.  Sinatra defaults to development,
# so we have to override that unless we want to set RACK_ENV=test from the
# command line when we run rake spec.  That's tedious, so do it here.
ENV['RACK_ENV'] ||= 'test'

require File.expand_path("../../config/environment", __FILE__)
require 'shoulda-matchers'
require 'rack/test'
require 'capybara'
require 'capybara/rspec'
require "selenium-webdriver"

RSpec.configure do |config|
  config.include Rack::Test::Methods
end

def app
  Sinatra::Application
end

Capybara.app = app.new

def sign_in_a_user(username)
  visit 'sessions/new'
  within("#sign-in") do
    fill_in 'signin-email', :with => "#{username}@yahoo.com"
    fill_in 'signin-password', :with => '333666'
  end
  click_button 'Login'
end

def create_a_new_user(username)
  visit 'sessions/new'
  within("#sign-up") do
    fill_in 'signup-username', :with => username
    fill_in 'signup-email', :with => "#{username}@yahoo.com"
    fill_in 'signup-password', :with => '333666'
  end
  click_button 'Create'
  expect(page).to have_content 'New user reated successfully'
end