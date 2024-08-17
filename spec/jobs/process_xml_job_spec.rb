require 'rails_helper'
require 'nokogiri'

RSpec.describe ProcessXmlJob, type: :job do
  let!(:xml_file) { create(:xml_file) }
  let!(:xml_content) { File.read(Rails.root.join('spec', 'fixtures', 'files', 'CASE 001 - NFe_004-000500778 .xml')) }
  let!(:doc) { Nokogiri::XML(xml_content) }

  before do
    allow_any_instance_of(ActiveStorage::Blob).to receive(:download).and_return(xml_content)
  end

  it 'creates an Issuer record from the XML' do
    expect { ProcessXmlJob.perform_now(xml_file.id) }.to change(Issuer, :count).by(1)
    issuer = Issuer.last
    expect(issuer.xml_file).to eq(xml_file)
    expect(issuer.cnpj).to eq('60124452000107')
  end

  it 'creates a Recipient record from the XML' do
    expect { ProcessXmlJob.perform_now(xml_file.id) }.to change(Recipient, :count).by(1)
    recipient = Recipient.last
    expect(recipient.xml_file).to eq(xml_file)
    expect(recipient.cnpj).to eq('08370779000149')
  end

  it 'creates a DataNote record from the XML' do
    expect { ProcessXmlJob.perform_now(xml_file.id) }.to change(DataNote, :count).by(1)
    data_note = DataNote.last
    expect(data_note.xml_file).to eq(xml_file)
    expect(data_note.series).to eq('4')
    expect(data_note.invoice_number).to eq('500778')
  end

  it 'creates Product records from the XML' do
    expect { ProcessXmlJob.perform_now(xml_file.id) }.to change(Product, :count).by(2)
    products = Product.all
    expect(products.size).to eq(2)
    expect(products.first.product_name).to eq('Batata frita')
  end
end
