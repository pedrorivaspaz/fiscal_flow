require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#format_cep' do
    it 'formats a CEP correctly' do
      expect(helper.format_cep('12345678')).to eq('12345-678')
      expect(helper.format_cep('98765432')).to eq('98765-432')
    end
  end

  describe '#format_cnpj' do
    it 'formats a CNPJ correctly' do
      expect(helper.format_cnpj('12345678000195')).to eq('12.345.678/0001-95')
      expect(helper.format_cnpj('98765432000123')).to eq('98.765.432/0001-23')
    end
  end

  describe '#format_phone' do
    it 'formats a phone number correctly' do
      expect(helper.format_phone('12945678901')).to eq('(12) 94567-8901')
      expect(helper.format_phone('98976543210')).to eq('(98) 97654-3210')
    end
  end
end