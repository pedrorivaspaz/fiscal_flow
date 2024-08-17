require 'rails_helper'

RSpec.describe DataNote, type: :model do
  it { should belong_to(:xml_file) }
end