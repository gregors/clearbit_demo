require_relative '../../services/bank_data'

describe BankData do
  describe '.plaid_transactions' do
    it 'retrieves a signle transaction' do
      trans = [instance_double('Plaid::Models::Transaction')]

      response = instance_double('Plaid::GetResponse', transactions: trans)
      allow(response).to receive(:[]) .with('total_transactions') .and_return(1)

      client = instance_double('Plaid::Client')
      allow(client).to receive_message_chain(:transactions, get: response)

      expect(BankData.plaid_transactions(client, '').size).to eq 1
    end

    it 'retrieves transactions' do
      trans1 = [instance_double('Plaid::Models::Transaction')]
      trans2 = [instance_double('Plaid::Models::Transaction')]

      response = instance_double('Plaid::GetResponse')
      allow(response).to receive(:transactions).and_return(trans1, trans2)
      allow(response).to receive(:[]).with('total_transactions').and_return(2, 0)

      client = instance_double('Plaid::Client')
      allow(client).to receive_message_chain(:transactions, get: response)

      expect(BankData.plaid_transactions(client, '').size).to eq 2
    end

    context 'with an error' do
      it 'returns an empty array' do
        client = instance_double('Plaid::Client')
        allow(client).to receive_message_chain(:transactions)
          .and_raise(Plaid::ItemError.new('1', '2', '3', '4', '5'))
        expect(BankData.plaid_transactions(client, '')).to eq []
      end
    end
  end
end
