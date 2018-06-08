require_relative '../../services/clearbit_data'

describe ClearbitData do
  describe '.name_domain_find_all' do
    it 'calls name_domain for each name' do
      expect(Clearbit::NameDomain).to receive(:find).twice
      ClearbitData.name_domain_find_all(%w[one two])
    end
  end

  let(:data) do
    [Transaction.new('Clearbit', '2018-05-26', 1, []),
     Transaction.new('Clearbit', '2018-05-26', 1, [])]
  end

  describe '.unique_names' do
    it 'removes duplicate names' do
      names = ClearbitData.unique_names(data)
      expect(names.size).to eq 1
      expect(names.first).to eq 'Clearbit'
    end
  end

  describe '.enrich_data' do
    it 'adds domain/logo data when available' do
      expect(Clearbit::NameDomain).to receive(:find).and_return('domain' => 'www.clearbit.com', 'logo' => 'logo')
      output = ClearbitData.enrich(data).first
      expect(output.domain).to eq 'www.clearbit.com'
      expect(output.logo).to eq 'logo'
    end
  end
end
