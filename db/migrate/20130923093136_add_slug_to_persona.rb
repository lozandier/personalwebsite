class AddSlugToPersona < ActiveRecord::Migration
  def change
    add_column :personas, :slug, :string
  end
end
