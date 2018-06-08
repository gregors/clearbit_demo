require_relative '../../services/name_cleanser'

describe NameCleanser do
  describe '.clean' do
    context 'with an uber entry' do
      it 'returns uber' do
        expect(NameCleanser.clean('Uber 072515 SF**POOL**')).to eq 'uber'
      end
    end

    context 'with a SparkFun entry' do
      it 'returns SparkFun Electronics' do
        expect(NameCleanser.clean('SparkFun')).to eq 'SparkFun Electronics'
      end
    end

    context 'with a normalentry' do
      it 'returns the entry' do
        expect(NameCleanser.clean('clearbit')).to eq 'clearbit'
      end
    end
  end
end
