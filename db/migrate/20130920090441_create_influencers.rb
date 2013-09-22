class CreateInfluencers < ActiveRecord::Migration
  def change
    create_table :influencers do |t|
      t.string :name
      t.decimal :percentage
      t.references :persona, index: true 
      t.timestamps
    end
  end
end
