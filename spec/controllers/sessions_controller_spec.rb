ENV['RACK_ENV'] = 'test'

require_relative '../../app'
require 'rspec'
require 'rack/test'

describe 'sessions' do
  include Rack::Test::Methods

  def app
    App
  end

  describe 'POST & DELETE /session' do
    it 'creates and destroys a session' do
      client = instance_double('Plaid::Client')
      expect(Plaid::Client).to receive(:new).with(any_args).and_return(client)
      allow(client).to receive_message_chain(:item, :public_token, :exchange).and_return('access_token' => 'fake-token')

      post '/session', 'public_token' => 'public-something-something'
      expect(last_response).to be_ok
      expect(last_response.body).to eq ''

      delete '/session'
      expect(session[:access_token]).to be_nil
      expect(last_response).to be_ok
      expect(last_response.body).to eq ''
    end
  end
end
