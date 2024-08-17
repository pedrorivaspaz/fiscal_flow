require 'zip'
require 'tempfile'

class XmlFilesController < ApplicationController

  def new
    @xml = XmlFile.new
  end

  def create
    if xml_files_params[:file].content_type == 'application/zip'
      process_zip_file(xml_files_params[:file])
    else
      process_xml_file(xml_files_params[:file])
    end
    redirect_to reports_path
  end
  
  private
  
  def process_zip_file(zip_file)
    Zip::File.open(zip_file.path) do |zip|
      zip.each do |entry|
        next unless entry.name.end_with?('.xml')
  
        xml_content = entry.get_input_stream.read
        original_filename = entry.name
  
        Tempfile.create([File.basename(entry.name, '.xml'), '.xml']) do |tempfile|
          tempfile.write(xml_content)
          tempfile.rewind
  
          process_xml_file(tempfile)
        end
      end
    end
  end
  
  def process_xml_file(xml_files_params)
    @xml = XmlFile.new(file: xml_files_params)
    
    if @xml.save
      ProcessXmlJob.perform_later(@xml.id)
      Report.create!(xml_file_id: @xml.id)
      flash[:notice] = 'Documento XML enviado com sucesso e está sendo processado.'
    else
      flash.now[:alert] = 'Erro ao processar o arquivo XML.'
    end
  end

  def xml_files_params
    params.require(:xml_file).permit(:file)
  end
end