class XmlFile < ApplicationRecord
  has_one :issuer
  has_one :recipient
  has_one :data_note
  has_one :report
  
  has_many :products

  has_one_attached :file

  validates :file, presence: true
end
