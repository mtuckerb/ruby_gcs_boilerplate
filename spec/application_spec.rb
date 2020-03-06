# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Application do
  before :all do
    skip_record do
      @authorize = Authorize.new(secret_file: './tmp/service_key.json', scope: 'https://www.googleapis.com/auth/calendar.events')
    end
  end

  it 'authenticates with Google' do
    expect(@authorize).to respond_to(:access_token)
  end

  it 'fetches a list of calendars' do
    VCR.use_cassette('get_calendars') do
      cal = CalClient.new(authorization: @authorize)
    end
  end
end
