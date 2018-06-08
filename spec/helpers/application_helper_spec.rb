require_relative '../../helpers/application_helper'

describe ApplicationHelper do
  let(:klass) { Class.new { include ApplicationHelper }.new }

  describe '#plaid_client' do
    it 'create the plaid client' do
      expect(Plaid::Client).to receive(:new).with(any_args)
      klass.plaid_client
    end
  end
end
