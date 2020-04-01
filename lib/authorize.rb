# frozen_string_literal: true

class Authorize
  class Service
    attr_accessor :authorize

    def initialize(secret_file:, scope: 'https://www.googleapis.com/auth/calendar')
      authorizer = Google::Auth::ServiceAccountCredentials.make_creds(
        json_key_io: File.open(secret_file),
        scope: scope
      )

      authorizer.fetch_access_token!
      raise AuthorizationError unless authorizer.access_token

      @authorize = authorizer
    end

    def authorize_all
      Google::Apis::RequestOptions.default.authorization = authorize
    end

    def authorize_for(user)
      auth_client = authorize.dup
      auth_client.sub = user
      auth_client.refresh!
    end

    def to_ary
      @authorize
    end

    def method_missing(method, *_args, &block)
      authorize.send(method.to_sym, &block)
    end

    def respond_to_missing?(method, include_private = false)
      method || super
    end
  end

  class User
    OOB_URI = "urn:ietf:wg:oauth:2.0:oob"
    APPLICATION_NAME = "Google Calendar API "
    CREDENTIALS_PATH = "tmp/credentials.json"
    TOKEN_PATH = "tmp/token.yaml"

    attr_accessor :credentials

    def initialize(scope:  'https://www.googleapis.com/auth/calendar', secret_file:, code: nil)
      client_id = Google::Auth::ClientId.from_file secret_file
      token_store = Google::Auth::Stores::FileTokenStore.new file: TOKEN_PATH
      authorizer = Google::Auth::UserAuthorizer.new client_id, scope, token_store
      user_id = "default"
      credentials = authorizer.get_credentials user_id
      if credentials.nil?
        url = authorizer.get_authorization_url base_url: OOB_URI
        puts "Open the following URL in the browser and enter the " \
             "resulting code after authorization:\n" + url
        code = code || gets
        credentials = authorizer.get_and_store_credentials_from_code(
          user_id: user_id, code: code, base_url: OOB_URI
        )
      end
      @credentials = credentials
    end

    def method_missing(m, *args, &block)
      credentials.send(m, *args, &block)
    end
  end
end
class AuthorizationError < StandardError
end
