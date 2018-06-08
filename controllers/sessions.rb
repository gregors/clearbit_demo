# frozen_string_literal: true

class App < Sinatra::Application
  post '/session' do
    exchange_token_response = plaid_client.item.public_token.exchange(params['public_token'])
    session[:access_token] = exchange_token_response['access_token']
    exchange_token_response.to_json
  end

  delete '/session' do
    session[:access_token] = nil
  end
end
