class Report < ApplicationRecord
  belongs_to :xml_file

  validates :xml_file, presence: true

end
