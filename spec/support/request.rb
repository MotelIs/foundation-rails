module Request

  def json_response
    JSON.parse(response.body)
  end

  RSpec.configure do |config|
    config.include Request
    config.include Request, type: :controller
  end
end
