
class CalClient

  attr_accessor :client, :result

  def initialize(authorization: )
    @client = Google::Apis::CalendarV3::CalendarService.new
    @client.client_options.application_name = ENV['APPLICATION_NAME']
    @client.authorization = authorization
  end

  def to_ary
    @client
  end

  def method_missing(method, *_args)
    @client.send(method.to_sym)
  end

end
