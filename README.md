# ruby_gcs_boilerplate

This is a place to put all of the libraries that I use for a greenfields ruby GCS project, so I can get started more easily.

I can't tell you how delighted I would be to see your PRs

# Install:

You'll need to:

1. put your client_secret.json in /tmp
1. and set up your .env and .env.test like so:

```

GCS_CLIENT_ID=
CGS_CLIENT_SECRET=
OOB_URI="urn:ietf:wg:oauth:2.0:oob"
APPLICATION_NAME="Google Calendar API Ruby Quickstart"
CREDENTIALS_PATH="credentials.json"
SCOPE=Google::Apis::CalendarV3::AUTH_CA
```

1. Download your `service_key.json` and `client_secret.json` from Google Cloud Dashboard:
   1. https://console.cloud.google.com/iam-admin/serviceaccounts
   1. https://console.developers.google.com/apis/credentials
2. In order to use user auth (`lib/authorize.rb` ) you'll need to get an Auth
   code:
   - `bundle exec irb -r ./application.rb`
   - Add all scopes you'll need now, or you're likely to forget (like I do) and
     be faced with a "invalid grant" error later on
     ```
     @auth = Authorize::User.new(secret_file: './tmp/client_secret.json', scope: [Google::Apis::AdminDirectoryV1::AUTH_ADMIN_DIRECTORY_USER_READONLY,Google::Apis::CalendarV3::AUTH_CALENDAR])
     ```
   - put the resulting code into your `.env.test` in the `USER_AUTH_CODE` env
     var.
