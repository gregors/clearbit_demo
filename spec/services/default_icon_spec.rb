require_relative '../../services/default_icon'

describe DefaultIcon do
  describe '.get' do
    subject { DefaultIcon.get(category) }

    context 'with a valid category' do
      let(:category) { ['deposit'] }

      it 'returns a default icon' do
        expect(subject).to start_with '<i class='
      end
    end

    context 'without a valid category' do
      let(:category) { ['game'] }

      it 'returns nil' do
        expect(subject).to be_nil
      end
    end

    context 'with no category' do
      let(:category) { [] }

      it 'returns nil' do
        expect(subject).to be_nil
      end
    end
  end
end
