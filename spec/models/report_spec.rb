require 'rails_helper'

RSpec.describe Report, type: :model do
  let!(:xml_file) { create(:xml_file) }
  let!(:issuer) { create(:issuer, xml_file: xml_file) }
  let!(:recipient) { create(:recipient, xml_file: xml_file) }
  let!(:data_note) { create(:data_note, xml_file: xml_file) }
  let!(:product) { create(:product, xml_file: xml_file) }
  let!(:report) { create(:report, xml_file: xml_file) }

  describe 'associations' do
    it { should belong_to(:xml_file) }
    it { should have_one(:issuer).through(:xml_file) }
    it { should have_one(:recipient).through(:xml_file) }
    it { should have_one(:data_note).through(:xml_file) }
    it { should have_many(:products).through(:xml_file) }
  end

  describe 'validations' do
    it { should validate_presence_of(:xml_file) }
  end

  describe '.search_by_query' do
    context 'when searching by invoice number' do
      it 'returns the correct report' do
        expect(Report.search_by_query('1234567890')).to include(report)
      end
    end

    context 'when searching by issuer name' do
      it 'returns the correct report' do
        expect(Report.search_by_query('Issuer Name')).to include(report)
      end
    end

    context 'when searching by recipient cnpj' do
      it 'returns the correct report' do
        expect(Report.search_by_query('12345678000190')).to include(report)
      end
    end

    context 'when searching by product name' do
      it 'returns the correct report' do
        expect(Report.search_by_query('Product Name')).to include(report)
      end
    end

    context 'when no match is found' do
      it 'returns an empty result' do
        expect(Report.search_by_query('Nonexistent')).to be_empty
      end
    end
  end
end