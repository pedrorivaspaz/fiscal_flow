class Report < ApplicationRecord
  belongs_to :xml_file
  has_one :issuer, through: :xml_file
  has_one :recipient, through: :xml_file
  has_one :data_note, through: :xml_file
  has_many :products, through: :xml_file

  validates :xml_file, presence: true

  default_scope { order(created_at: :desc) }

  def self.search_by_query(query)
    search_query = "%#{query}%"
  
    joins(xml_file: [:issuer, :recipient, :data_note, :products])
    .where('
        issuers.name LIKE ? OR issuers.address LIKE ? OR
        recipients.name LIKE ? OR
        products.product_name LIKE ? ',
        search_query, search_query,
        search_query, search_query
      )
  end

end
