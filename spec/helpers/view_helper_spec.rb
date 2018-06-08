require_relative '../../helpers/view_helper'

describe ViewHelper do
  let(:klass) { Class.new { include ViewHelper }.new }

  describe '#format_currency' do
    it 'formats output number' do
      expect(klass.format_currency(-222)).to eq '$ -222.00'
    end
  end

  describe '#recurring?' do
    context 'with a recurring transaction' do
      let(:transaction) { instance_double('Transaction', recurring?: true) }

      it 'outputs a stopwatch icon' do
        expect(klass.recurring?(transaction)).to eq '<i class="fas fa-stopwatch"></i>'
      end
    end

    context 'with a non-recurring transaction' do
      let(:transaction) { instance_double('Transaction', recurring?: false) }

      it 'outputs an empty string' do
        expect(klass.recurring?(transaction)).to eq ''
      end
    end
  end

  describe '#name_helper' do
    context 'transaction with a domain' do
      let(:transaction) { instance_double('Transaction', domain: 'clearbit.com', name: 'Clearbit') }

      it 'produces an anchor tag' do
        expect(klass.name_helper(transaction)).to eq '<a href="http://clearbit.com">Clearbit</a>'
      end
    end

    context 'transaction without a domain' do
      let(:transaction) do
        instance_double('Transaction', domain: nil, name: 'Clearbit')
      end

      it 'outputs simple name content' do
        expect(klass.name_helper(transaction)).to eq 'Clearbit'
      end
    end
  end

  describe '#href' do
    it 'returns an anchor tag' do
      expect(klass.href('clearbit.com', 'Clearbit')).to eq '<a href="http://clearbit.com">Clearbit</a>'
    end
  end

  describe '#delete_link_js' do
    it 'returns a jquery delete http link' do
      expect(klass.delete_link_js('#id', '/home', '/')).to eq %[$('#id').on('click', function(e) {\n         $.post('/home', {_method: 'delete'}, function() { window.location.href = '/' });\n       });]
    end
  end

  describe '#logo_helper' do
    context 'with a logo' do
      let(:transaction) { instance_double('Transaction', logo: 'logo') }

      it 'returns a logo image' do
        expect(klass.logo_helper(transaction)).to eq '<img src="logo" class="rounded-circle thumbnail" />'
      end
    end
    context 'without a logo' do
      context 'is an interest transaction' do
        let(:transaction) { instance_double('Transaction', logo: nil, interest?: true) }

        it 'returns the default interest logo' do
          expect(klass.logo_helper(transaction)).to eq '<i class="fas fa-hand-holding-usd"></i>'
        end
      end

      context 'is not an interest transaction' do
        let(:transaction) { instance_double('Transaction', logo: nil, interest?: false, categories: ['something']) }

        it 'returns the default interest logo' do
          expect(klass.logo_helper(transaction)).to eq '<i class="fas fa-file"></i>'
        end
      end
    end
  end
end
