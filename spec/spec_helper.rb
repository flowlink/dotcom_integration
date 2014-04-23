require 'rubygems'
require 'bundler'

Bundler.require(:default, :test)

require File.join(File.dirname(__FILE__), '..', 'dotcom_endpoint.rb')
Dir["./spec/support/**/*.rb"].each {|f| require f}

require 'spree/testing_support/controllers'

Sinatra::Base.environment = 'test'

def app
  DotcomEndpoint
end

VCR.configure do |c|
  c.cassette_library_dir = 'spec/vcr_cassettes'
  c.hook_into :webmock
end

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.include Spree::TestingSupport::Controllers
end

ENV['ENDPOINT_KEY'] = 'x123'
