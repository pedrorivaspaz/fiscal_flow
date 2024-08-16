class ReportsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_report, only: [:show, :export_excel]
  before_action :show, only: [:export_excel]
  
  def index
    @pagy, @reports = pagy(filtered_reports)
  end

  def show
    @xml_file = @report.xml_file
    @issuer = @xml_file.issuer
    @recipient = @xml_file.recipient
    @data_note = @xml_file.data_note
    @products = @xml_file.products
  end

  def export_excel
    respond_to do |format|
      format.xlsx do
        response.headers['Content-Disposition'] = "attachment; filename=Relatório XMl#{params[:id]}.xlsx"
      end
    end
  end

  private

  def filtered_reports
    reports = Report.all
    @query = params[:query]
    if params[:query].present?
      reports = Report.search_by_query(@query)
    end

    reports
  end

  def set_report
    @report = Report.find(params[:id])
  end
end
