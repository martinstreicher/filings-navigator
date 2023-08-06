# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BaseReturn do
  let(:fail_one)      { {} }
  let(:fail_two)      { { 'Name' => {} } }
  let(:match)         { 'Gadget, Inc' }
  let(:pattern)       { '{Name,BusinessName}/{BusinessNameLine1,BusinessNameLine1Txt}' }
  let(:success_one)   { { 'Name' => { 'BusinessNameLine1' => target } } }
  let(:success_two)   { { 'BusinessName' => { 'BusinessNameLine1Txt' => target } } }
  let(:success_three) { { 'Name' => { 'BusinessNameLine1Txt' => target } } }
  let(:target)        { match }

  describe '#diggin' do
    it 'returns the value of the desired key' do
      expect(described_class.new(success_one).diggin(pattern)).to eq(match)
      expect(described_class.new(success_two).diggin(pattern)).to eq(match)
      expect(described_class.new(success_three).diggin(pattern)).to eq(match)
    end

    it 'returns nil if the key is not found' do
      expect(described_class.new(fail_one).diggin(pattern)).to be_nil
      expect(described_class.new(fail_two).diggin(pattern)).to be_nil
    end

    context 'when multiple paths are provided' do
      let(:match)  { 'Inc.' }
      let(:target) { { 'Incorporation' => match } }

      let(:patterns) do
        [
          '{Name,BusinessName}/{BusinessNameLine1,BusinessNameLine1Txt}',
          'Incorporation'
        ]
      end

      it 'returns the value of the desired key' do
        expect(described_class.new(success_three).diggin(*patterns)).to eq(match)
      end
    end
  end
end
