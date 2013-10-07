class AddSeoAndProjectCountFieldToTechnologies < ActiveRecord::Migration
  def change
    add_column :technologies, :byline, :string 
    add_column :technologies, :projects_count, :integer, default: 0
  end
end
