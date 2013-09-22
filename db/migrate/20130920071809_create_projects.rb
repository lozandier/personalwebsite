class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :title
      t.text :description 
      t.attachment :cover
      t.text :medium 
      t.text :state 
      t.timestamps
    end
  end
end
