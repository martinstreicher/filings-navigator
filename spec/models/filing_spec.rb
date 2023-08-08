# frozen_string_literal: true

RSpec.describe Filing do
  describe "with scope valid_for_tax_period" do
    let(:filer)      { create(:filer) }
    let(:tax_period) { '2017-12-31' }

    let!(:decoy)    { create(:filing, amended_return: true, return_timestamp: 1.hour.ago, tax_period: tax_period ) }
    let!(:filing_a) { create(:filing, filer: filer, return_timestamp: 1.hour.ago, tax_period: tax_period ) }

    let!(:filing_b) do
      create(
        :filing,
        amended_return: true,
        filer: filer,
        return_timestamp: 3.hours.ago,
        tax_period: tax_period
      )
    end

    let!(:filing_c) { create(:filing, filer: filer, return_timestamp: 1.day.ago, tax_period: tax_period ) }

    it 'returns the most recent filing preferring amended returns first' do
      expect(filer.filings.valid_for_tax_period(tax_period)).to eq([filing_b])
    end
  end
end
