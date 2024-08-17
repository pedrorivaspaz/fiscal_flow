require 'rails_helper'

RSpec.describe Issuer, type: :model do
  it { should belong_to(:xml_file) }
end