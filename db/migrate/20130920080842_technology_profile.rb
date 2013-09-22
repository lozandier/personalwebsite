class TechnologyProfile < ActiveRecord::Migration
  def change
    create_table :technology_profiles do |t| 
      t.references :technology, index: true 
      t.references :project, index: true
      t.integer :percentage_of_project 
    end
  end
end
