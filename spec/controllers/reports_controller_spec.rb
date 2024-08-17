require 'rails_helper'

RSpec.describe ReportsController, type: :controller do
  let(:xml_file) { create(:xml_file) }
  let(:report) { create(:report, xml_file: xml_file) }

  before do
    allow(controller).to receive(:authenticate_user!)
  end

  describe "GET #index" do
    it "assigns @reports and paginates them" do
      get :index
      expect(assigns(:reports)).to eq([report])
      expect(response).to render_template(:index)
    end
  end

  describe "GET #show" do
    it "assigns report details to instance variables" do
      get :show, params: { id: report.id }
      expect(assigns(:xml_file)).to eq(report.xml_file)
      expect(assigns(:issuer)).to eq(xml_file.issuer)
      expect(assigns(:recipient)).to eq(xml_file.recipient)
      expect(assigns(:data_note)).to eq(xml_file.data_note)
      expect(assigns(:products)).to eq(xml_file.products)
      expect(response).to render_template(:show)
    end
  end

  describe "GET #export_excel" do
    it "responds with an xlsx file" do
      get :export_excel, params: { id: report.id }, format: :xlsx
      expect(response.headers['Content-Disposition']).to include("attachment; filename=Relatório XMl#{report.id}.xlsx")
      expect(response.content_type).to include("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet")
    end
  end

  describe "before actions" do
    it "sets the report for show and export_excel actions" do
      expect(controller).to receive(:set_report).and_call_original
      get :show, params: { id: report.id }
      expect(assigns(:report)).to eq(report)

      expect(controller).to receive(:set_report).and_call_original
      get :export_excel, params: { id: report.id }, format: :xlsx
      expect(assigns(:report)).to eq(report)
    end
  end
end
