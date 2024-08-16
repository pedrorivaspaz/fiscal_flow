class CreateDataNote < ActiveRecord::Migration[7.2]
  def change
    create_table :data_notes do |t|
      t.string :series
      t.string :invoice_number
      t.datetime :emission_date
      t.decimal :icms, precision: 10, scale: 2
      t.decimal :ipi, precision: 10, scale: 2
      t.decimal :pis, precision: 10, scale: 2
      t.decimal :cofins, precision: 10, scale: 2
      t.decimal :total_products, precision: 15, scale: 2
      t.decimal :total_taxes, precision: 15, scale: 2

      t.references :xml_file, null: false, foreign_key: true
      t.timestamps
    end
  end
end
