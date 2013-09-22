class CreateIdentityGuidelines < ActiveRecord::Migration
  def change
    create_table :identity_guidelines do |t|
      t.attachment :brand_image 
      t.attachment :background_image 
      t.string :brand_name
      t.text :overview
      t.text :description
      t.references :project, index: true
      t.timestamps
    end
  end
end
