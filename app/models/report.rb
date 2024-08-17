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

    joins(xml_file: [:products, :issuer, :recipient, :data_note])
      .where('
        data_notes.invoice_number ILIKE :search_query OR
        issuers.name ILIKE :search_query OR 
        issuers.cnpj ILIKE :search_query OR
        issuers.fantasy_name ILIKE :search_query OR
        issuers.address ILIKE :search_query OR 
        recipients.name ILIKE :search_query OR
        recipients.cnpj ILIKE :search_query OR 
        recipients.fantasy_name ILIKE :search_query OR
        recipients.address ILIKE :search_query OR
        products.product_name ILIKE :search_query',
        search_query: search_query
      )
  end
end
