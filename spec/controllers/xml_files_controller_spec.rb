require 'rails_helper'

RSpec.describe XmlFilesController, type: :controller do
  include Devise::Test::ControllerHelpers

  let(:valid_zip_file) do
    fixture_file_upload(Rails.root.join('spec', 'fixtures', 'files', 'xpto.zip'), 'application/zip')
  end

  let(:valid_xml_file) do
    fixture_file_upload(Rails.root.join('spec', 'fixtures', 'files', 'CASE 001 - NFe_004-000500778 .xml'), 'text/xml')
  end

  before do
    allow(controller).to receive(:authenticate_user!)
  end

  describe 'GET #new' do
    it 'assigns a new XmlFile to @xml' do
      get :new
      expect(assigns(:xml)).to be_a_new(XmlFile)
    end
  end

  describe 'POST #create' do
    context 'when a ZIP file is uploaded' do
      it 'processes the ZIP file and enqueues jobs for the XML files inside it' do
        expect { post :create, params: { xml_file: { file: valid_zip_file } } }
          .to change { Report.count }.by(2)
          
        expect(flash[:notice]).to eq('Documento XML enviado com sucesso e está sendo processado.')
        expect(response).to redirect_to(reports_path)
      end
    end

    context 'when an XML file is uploaded' do
      it 'processes the XML file and enqueues the job' do
        expect { post :create, params: { xml_file: { file: valid_xml_file } } }
          .to change { Report.count }.by(1)
          
        expect(ProcessXmlJob).to have_been_enqueued
        expect(flash[:notice]).to eq('Documento XML enviado com sucesso e está sendo processado.')
        expect(response).to redirect_to(reports_path)
      end
    end
  end
end
