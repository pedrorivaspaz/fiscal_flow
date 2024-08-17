FactoryBot.define do
  factory :recipient do
    name { 'Recipient Name' }
    cnpj { '98765432000101' }
    fantasy_name { 'Recipient Fantasy Name' }

    association :xml_file
  end
end