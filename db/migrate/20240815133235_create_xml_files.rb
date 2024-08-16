class CreateXmlFiles < ActiveRecord::Migration[7.2]
  def change
    create_table :xml_files do |t|
      
      t.timestamps
    end
  end
end