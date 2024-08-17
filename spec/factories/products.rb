FactoryBot.define do
  factory :product do
    product_name { 'Product Name' }

    association :xml_file
  end
end