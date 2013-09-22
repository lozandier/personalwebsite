class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.attachment :avatar
      t.text :biography
      t.string :industry
      t.references :project, index: true 
      t.timestamps
    end
  end
end
