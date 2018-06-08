# frozen_string_literal: true

require_relative '../../models/category'

describe Category do
  subject { Category.new(categories) }

  describe '#recurring?' do
    context 'with subscription category' do
      let(:categories) { %w[other Subscription] }

      it 'is true' do
        expect(subject.recurring?).to be_truthy
      end
    end

    context 'without subscription category ' do
      let(:categories) { ['other'] }

      it 'is false' do
        expect(subject.recurring?).to be_falsy
      end
    end
  end

  describe '#last' do
    context 'with categories' do
      let(:categories) { %w[other Subscription] }

      it 'returns the last most relevant category' do
        expect(subject.last).to eq 'Subscription'
      end
    end

    context 'without categories' do
      let(:categories) { [] }

      it 'returns nil' do
        expect(subject.last).to be_nil
      end
    end
  end
end
