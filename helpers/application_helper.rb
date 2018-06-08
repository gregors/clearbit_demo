# frozen_string_literal: true

require 'plaid'

module ApplicationHelper
  def plaid_client
    @plaid_client ||= Plaid::Client.new(env: :sandbox,
                                        client_id: ENV['PLAID_CLIENT_ID'],
                                        secret: ENV['PLAID_SECRET'],
                                        public_key: ENV['PLAID_PUBLIC_KEY'])
  end
end
