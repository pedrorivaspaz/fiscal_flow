require 'zip'

class XmlFilesController < ApplicationController

  def new
    @xml = XmlFile.new
  end

  def create
    if xml_files_params[:file].content_type == 'application/zip'
      process_zip_file(xml_files_params[:file])
    else xml_files_params[:file].content_type == 'text/xml'
      process_xml_file(xml_files_params[:file])
    end
    redirect_to reports_path
  end
  
  private
  
  def process_zip_file(zip_file)
    debugger
    Zip::File.open(zip_file.path) do |zip|
      zip.each do |entry|
        next unless entry.name.end_with?('.xml')
        process_xml_file(entry.get_input_stream.read)
      end
    end
  end
  
  def process_xml_file(xml_content)
    @xml = XmlFile.new(file: xml_content)
    if @xml.save
      ProcessXmlJob.perform_later(@xml.id)
      Report.create!(xml_file_id: @xml.id)
      flash[:notice] = 'Documento XML enviado com sucesso e está sendo processado.'
      redirect_to reports_path
    else
      flash.now[:alert] = 'Erro ao processar o arquivo XML.'
      render :new
    end
  end

  private

  def xml_files_params
    params.require(:xml_file).permit(:file)
  end
end