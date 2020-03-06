class Authorize

  attr_accessor :authorize

  def initialize(secret_file: , scope: 'https://www.googleapis.com/auth/androidpublisher')


    authorizer = Google::Auth::ServiceAccountCredentials.make_creds(
      json_key_io: File.open(secret_file),
      scope: scope)

    authorizer.fetch_access_token!
    raise AuthorizationError unless authorizer.access_token
    @authorize = authorizer
  end

  def to_ary
    @authorize
  end

  def method_missing(method, *_args)
    authorize.send(method.to_sym)
  end

  def respond_to_missing?(method, include_private = false)
    method|| super
  end

end

class AuthorizationError < StandardError

end
