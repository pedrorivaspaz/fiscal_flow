class CreateProduct < ActiveRecord::Migration[7.2]
  def change
    create_table :products do |t|
      t.string :product_name
      t.string :ncm
      t.string :cfop
      t.string :unit
      t.decimal :quantity, precision: 10, scale: 2
      t.decimal :unit_value, precision: 10, scale: 2

      t.references :xml_file, null: false, foreign_key: true
      t.timestamps
    end
  end
end
