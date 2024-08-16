class CreateReports < ActiveRecord::Migration[7.2]
  def change
    create_table :reports do |t|
      t.references :xml_file, null: false, foreign_key: true
      t.timestamps
    end
  end
end
