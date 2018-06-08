# frozen_string_literal: true

describe Transaction do
  subject { Transaction.new('Clearbit', '2018-05-26', 1, []) }

  describe '.new' do
    its(:name) { should eq 'Clearbit' }
    its(:date) { should eq Date.new(2018, 5, 26) }
    its(:amount) { should eq 1 }
  end

  describe '.from_plaid_transactions' do
    let(:plaid_data) do
      [
        instance_double('Plaid::Models::Transaction', name: 'a', date: '2018-05-28', amount: 1, category: ['']),
        instance_double('Plaid::Models::Transaction', name: 'b', date: '2018-05-20', amount: 2, category: ['']),
        instance_double('Plaid::Models::Transaction', name: 'c', date: '2018-05-23', amount: 4, category: ['']),
        instance_double('Plaid::Models::Transaction', name: 'd', date: '2018-05-21', amount: 2, category: [''])
      ]
    end

    it 'returns an array of transactions' do
      output = Transaction.from_plaid_transactions(plaid_data)
      expect(output.size).to eq 4
    end

    it 'transactions are sorted by date' do
      output = Transaction.from_plaid_transactions(plaid_data)
      expect(output.first.date).to eq Date.new(2018, 0o5, 20)
      expect(output.last.date).to eq Date.new(2018, 0o5, 28)
    end
  end

  describe '#categoryies' do
    it 'returns categories' do
      expect(subject.categories.class).to eq Category
    end
  end

  describe '.interest?' do
    context 'with an interest transaction' do
      subject { Transaction.new('INTRST PYMNT', '2018-05-26', 0, []) }

      it 'returns true' do
        expect(subject.interest?).to be_truthy
      end
    end

    context 'without an interest transaction' do
      it 'returns true' do
        expect(subject.interest?).to be_falsy
      end
    end
  end

  describe '.recurring?' do
    context 'with an subscription category' do
      subject { Transaction.new('', '2018-05-26', 0, ['Subscription']) }
      it 'returns true' do
        expect(subject.recurring?).to be_truthy
      end
    end

    context 'without an subscription category' do
      it 'returns false' do
        expect(subject.recurring?).to be_falsy
      end
    end
  end
end
