ENV['RACK_ENV'] = 'test'
require_relative '../../app'
require 'rspec'
require 'rack/test'

describe 'transactions' do
  include Rack::Test::Methods

  def app
    App
  end

  describe 'GET /transactions' do
    it 'gets transactions' do
      # set session
      client = instance_double('Plaid::Client')
      expect(Plaid::Client).to receive(:new) .with(any_args) .and_return(client, client)
      allow(client).to receive_message_chain(:item, :public_token, :exchange).and_return('access_token' => 'fake-token')

      post '/session', 'public_token' => 'public-something-something'
      expect(last_response).to be_ok
      expect(last_response.body).to eq ''

      trans = [instance_double('Plaid::Models::Transaction', name: 'greg', date: '2018-1-1', amount: 5, category: [])]
      expect(BankData).to receive(:plaid_transactions) .with(any_args) .and_return(trans)

      expect(ClearbitData).to receive(:enrich) .with(any_args)
                                               .and_return([Transaction.new('greg', '2018-01-1', 5, [])])

      get '/transactions'

      expect(last_response).to be_ok
      expect(last_response.body).to include 'greg'
      expect(last_response.body).to include '5.00'
    end
  end
end
