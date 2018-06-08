ENV['RACK_ENV'] = 'test'

require_relative '../../app'
require 'rspec'
require 'rack/test'

describe 'The home page' do
  include Rack::Test::Methods

  def app
    App
  end

  describe 'GET /' do
    it 'loads the landing  page' do
      get '/'
      expect(last_response).to be_ok
      expect(last_response.body).to include('Please Link Accounts')
    end
  end

  describe 'GET unknown route' do
    it 'results in a 404 page' do
      get '/random'
      expect(last_response.status).to eq 404
      expect(last_response.body).to include('~ 404 ~')
    end
  end
end
