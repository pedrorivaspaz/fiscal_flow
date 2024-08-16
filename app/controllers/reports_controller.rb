class ReportsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_report, only: [:show]
  
  def index
    @reports = Report.all
  end

  def show
    @xml_file = @report.xml_file
    @issuer = @xml_file.issuer
    @recipient = @xml_file.recipient
    @data_note = @xml_file.data_note
    @products = @xml_file.products
  end

  private

  def set_report
    @report = Report.find(params[:id])
  end
end
