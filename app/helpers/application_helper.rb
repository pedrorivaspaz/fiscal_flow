module ApplicationHelper
  include Pagy::Frontend
  
  def format_cep(cep)
    cep.to_s.gsub(/(\d{5})(\d{3})/, '\1-\2')
  end

  def format_cnpj(cnpj)
    cnpj.to_s.gsub(/(\d{2})(\d{3})(\d{3})(\d{4})(\d{2})/, '\1.\2.\3/\4-\5')
  end

  def format_phone(phone)
    phone.to_s.gsub(/(\d{2})(\d{5})(\d{4})/, '(\1) \2-\3')
  end
end
