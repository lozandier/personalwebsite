class AddColumnsToPersonas < ActiveRecord::Migration
  def change
    add_column :personas, :creative_commons_license, :string, default: 'None'
    add_column :personas, :creative_commons_attribution, :string
    add_column :personas, :creative_commons_attribution_link, :string
  end
end
