require 'rails_helper'

RSpec.describe XmlFile, type: :model do
  it { should have_one_attached(:file) }
end