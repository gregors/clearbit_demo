# frozen_string_literal: true

class App < Sinatra::Application
  get '/transactions' do
    data = BankData.plaid_transactions(plaid_client, session[:access_token])
    @transactions = Transaction.from_plaid_transactions(data)
    @transactions = ClearbitData.enrich(@transactions)

    erb :transactions
  end
end
