FactoryBot.define do
  factory :issuer do
    name { 'Issuer Name' }
    cnpj { '12345678000190' }
    fantasy_name { 'Issuer Fantasy Name' }

    association :xml_file
  end
end