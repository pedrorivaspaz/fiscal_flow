require 'rails_helper'

RSpec.describe Recipient, type: :model do
  it { should belong_to(:xml_file) }
end