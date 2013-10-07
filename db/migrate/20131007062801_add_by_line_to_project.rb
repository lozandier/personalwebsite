class AddByLineToProject < ActiveRecord::Migration
  def change
    add_column :projects, :byline, :string
  end
end
