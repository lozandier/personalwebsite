class AddReleaseRelatedColumnsToProject < ActiveRecord::Migration
  def change
    add_column :projects, :experiment, :boolean
    add_column :projects, :released_on, :date
    add_column :projects, :url, :string
    add_column :projects, :missing_url_reason, :string
  end
end
