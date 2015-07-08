class Api::V1::CustomTokensController < Doorkeeper::TokensController

  def create
    response = authorize_response
    self.headers.merge! response.headers

    body = response.body
    if response.try(:token)
      body[:user_id] = response.token.resource_owner_id
    end
    self.response_body = body.to_json
    self.status        = response.status
  rescue Doorkeeper::Errors::DoorkeeperError => e
    handle_token_exception e
  end
end
