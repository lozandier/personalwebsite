class CreatePersonas < ActiveRecord::Migration
  def change
    create_table :personas do |t|
      t.attachment :avatar
      t.attachment :background_image
      t.string :first_name
      t.string :last_name
      t.integer :age
      t.string :occupation 
      t.string :byline 
      t.text :description
      t.references :project, index: true
      t.string :state 
      t.timestamps
    end
  end
end
