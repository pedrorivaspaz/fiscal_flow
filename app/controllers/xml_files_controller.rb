class XmlFilesController < ApplicationController
  def new
    @xml = XmlFile.new
  end

  def create
    @xml = XmlFile.new(xml_files_params)
    if @xml.save
      ProcessXmlJob.perform_later(@xml.id)
      Report.create!(xml_file_id: @xml.id)
      flash[:notice] = 'Documento enviado com sucesso e está sendo processado.'
      redirect_to reports_path
    else
      flash.now[:alert] = 'Erro ao enviar o documento.'
      render :new
    end
  end

  private

  def xml_files_params
    params.require(:xml_file).permit(:file)
  end
end