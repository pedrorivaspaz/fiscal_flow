FactoryBot.define do
  factory :xml_file do
    file { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/CASE 001 - NFe_004-000500778 .xml'), 'application/xml') }
  end
end
