# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Application do
  before :all do
    skip_record do
      @authorize = Authorize::Service.new(secret_file: './tmp/service_key.json',
                                          scope: Google::Apis::CalendarV3::AUTH_CALENDAR)
      # you will need to run the test once and paste the url into your browser
      # to get this :code, then add it to .env.test 
      @user_auth = Authorize::User.new(
        code: ENV['USER_AUTH_CODE'],
        secret_file: './tmp/client_secret.json',
        scope: [
                Google::Apis::CalendarV3::AUTH_CALENDAR,
                Google::Apis::AdminDirectoryV1::AUTH_ADMIN_DIRECTORY_USER_READONLY]
      )
    end
  end

  it 'authenticates with Google' do
    expect(@authorize).to respond_to(:access_token)
  end

  it 'fetches a list of calendars' do
    skip_record do
      cal = CalClient.new(authorization: @user_auth.credentials)
      expect(cal.list_calendar_lists.items.count).to be > 0

    end
  end
end
