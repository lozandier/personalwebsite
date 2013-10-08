class AddSlugToTechnology < ActiveRecord::Migration
  def change
    add_column :technologies, :slug, :string
  end
end
