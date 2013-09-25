class AddColumnsToAttachments < ActiveRecord::Migration
  def change
    add_column :attachments, :name, :string
    add_column :attachments, :description, :text
  end
end
