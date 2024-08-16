require "nokogiri"

class ProcessXmlJob < ApplicationJob
  queue_as :default

  def perform(xml_file_id)
    xml_file = XmlFile.find(xml_file_id)
    xml_content = xml_file.file.download
    doc = Nokogiri::XML(xml_content)

    process_issuer(doc, xml_file_id )
    process_recipient(doc, xml_file_id )
    process_data(doc, xml_file_id )
    process_product(doc, xml_file_id )
  end

  private

  def process_issuer(doc, xml_file_id )
    namespaces = { "nfe" => "http://www.portalfiscal.inf.br/nfe" }
    issuer_note = doc.at_xpath('//nfe:emit', namespaces)
    return unless issuer_note

    Issuer.create!(
      xml_file_id: xml_file_id,
      cnpj: issuer_note.at_xpath('nfe:CNPJ', namespaces)&.text,
      name: issuer_note.at_xpath('nfe:xNome', namespaces)&.text,
      fantasy_name: issuer_note.at_xpath('nfe:xFant', namespaces)&.text,
      address: issuer_note.at_xpath('nfe:enderEmit/nfe:xLgr', namespaces)&.text,
      number: issuer_note.at_xpath('nfe:enderEmit/nfe:nro', namespaces)&.text,
      neighborhood: issuer_note.at_xpath('nfe:enderEmit/nfe:xBairro', namespaces)&.text,
      municipality_code: issuer_note.at_xpath('nfe:enderEmit/nfe:cMun', namespaces)&.text,
      municipality: issuer_note.at_xpath('nfe:enderEmit/nfe:xMun', namespaces)&.text,
      state: issuer_note.at_xpath('nfe:enderEmit/nfe:UF', namespaces)&.text,
      zip_code: issuer_note.at_xpath('nfe:enderEmit/nfe:CEP', namespaces)&.text,
      country_code: issuer_note.at_xpath('nfe:enderEmit/nfe:cPais', namespaces)&.text,
      country: issuer_note.at_xpath('nfe:enderEmit/nfe:xPais', namespaces)&.text,
      phone: issuer_note.at_xpath('nfe:enderEmit/nfe:fone', namespaces)&.text,
      state_registration: issuer_note.at_xpath('nfe:IE', namespaces)&.text
    )
  end

  def process_recipient(doc, xml_file_id)
    namespaces = { "nfe" => "http://www.portalfiscal.inf.br/nfe" }
    recipient_note = doc.at_xpath('//nfe:dest', namespaces)
    return unless recipient_note

    Recipient.create!(
      xml_file_id: xml_file_id,
      cnpj: recipient_note.at_xpath('nfe:CNPJ', namespaces)&.text,
      name: recipient_note.at_xpath('nfe:xNome', namespaces)&.text,
      fantasy_name: recipient_note.at_xpath('nfe:xFant', namespaces)&.text,
      address: recipient_note.at_xpath('nfe:enderDest/nfe:xLgr', namespaces)&.text,
      number: recipient_note.at_xpath('nfe:enderDest/nfe:nro', namespaces)&.text,
      neighborhood: recipient_note.at_xpath('nfe:enderDest/nfe:xBairro', namespaces)&.text,
      municipality_code: recipient_note.at_xpath('nfe:enderDest/nfe:cMun', namespaces)&.text,
      municipality: recipient_note.at_xpath('nfe:enderDest/nfe:xMun', namespaces)&.text,
      state: recipient_note.at_xpath('nfe:enderDest/nfe:UF', namespaces)&.text,
      zip_code: recipient_note.at_xpath('nfe:enderDest/nfe:CEP', namespaces)&.text,
      country_code: recipient_note.at_xpath('nfe:enderDest/nfe:cPais', namespaces)&.text,
      country: recipient_note.at_xpath('nfe:enderDest/nfe:xPais', namespaces)&.text,
    )
  end

  def process_data(doc, xml_file_id)
    namespaces = { "nfe" => "http://www.portalfiscal.inf.br/nfe" }
    data_note = doc.at_xpath('//nfe:ide', namespaces)
    data_impost = doc.at_xpath('//nfe:total/nfe:ICMSTot', namespaces)

    return unless data_note

    DataNote.create!(
      xml_file_id: xml_file_id,
      series: data_note.at_xpath('nfe:serie', namespaces)&.text,
      invoice_number: data_note.at_xpath('nfe:nNF', namespaces)&.text,
      emission_date: data_note.at_xpath('nfe:dhEmi', namespaces)&.text&.to_datetime,
      icms: data_impost.at_xpath('nfe:vICMS', namespaces)&.text,
      ipi: data_impost.at_xpath('nfe:vIPI', namespaces)&.text,
      pis: data_impost.at_xpath('nfe:vPIS', namespaces)&.text,
      cofins: data_impost.at_xpath('nfe:vCOFINS', namespaces)&.text,
      total_products: data_impost.at_xpath('nfe:vProd', namespaces)&.text,
      total_taxes: data_impost.at_xpath('nfe:vTotTrib', namespaces)&.text
    )
  end

  def process_product(doc, xml_file_id)
    namespaces = { "nfe" => "http://www.portalfiscal.inf.br/nfe" }
    product_nodes = doc.xpath('//nfe:det', namespaces)
    
    product_nodes.each do |product_node|
      product_name = product_node.at_xpath('nfe:prod/nfe:xProd', namespaces)&.text
      ncm = product_node.at_xpath('nfe:prod/nfe:NCM', namespaces)&.text
      cfop = product_node.at_xpath('nfe:prod/nfe:CFOP', namespaces)&.text
      unit = product_node.at_xpath('nfe:prod/nfe:uCom', namespaces)&.text
      quantity = product_node.at_xpath('nfe:prod/nfe:qCom', namespaces)&.text
      unit_value = product_node.at_xpath('nfe:prod/nfe:vUnCom', namespaces)&.text

      Product.create!(
        xml_file_id: xml_file_id,
        product_name: product_name,
        ncm: ncm,
        cfop: cfop,
        unit: unit,
        quantity: quantity,
        unit_value: unit_value
      )
    end
  end
end
