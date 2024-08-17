FactoryBot.define do
  factory :data_note do
    invoice_number { '1234567890' }
    emission_date { Time.current }

    association :xml_file
  end
end