# frozen_string_literal: true

require 'plaid'

class BankData
  def self.plaid_transactions(client, access_token)
    start_of_year = '2018-01-01'
    response = client.transactions.get(access_token, start_of_year, Date.today)

    trans = response.transactions
    while trans.length < response['total_transactions']
      response = client.transactions.get(access_token, start_of_year, Date.today, offset: trans.length)
      trans += response.transactions
    end

    trans
  rescue Plaid::ItemError
    []
  end
end
