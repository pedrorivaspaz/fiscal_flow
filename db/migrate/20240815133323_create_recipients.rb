class CreateRecipients < ActiveRecord::Migration[7.2]
  def change
    create_table :recipients do |t|
      t.string :cnpj
      t.string :name
      t.string :fantasy_name
      t.string :address
      t.string :number
      t.string :neighborhood
      t.string :municipality_code
      t.string :municipality
      t.string :state
      t.string :zip_code
      t.string :country_code
      t.string :country

      t.references :xml_file, null: false, foreign_key: true
      t.timestamps
    end
  end
end
