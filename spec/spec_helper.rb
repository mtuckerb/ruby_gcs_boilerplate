APP_ENV = 'test'
require './application'
require 'webmock/rspec'
require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = "./spec/fixtures/vcr_cassettes"
  config.hook_into :webmock
end

def skip_record(&block)
  WebMock.allow_net_connect!
  VCR.turn_off!
  yield
  VCR.turn_on!
  WebMock.disallow_net_connect!
end
