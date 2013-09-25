class AddSlugToAttachments < ActiveRecord::Migration
  def change
    add_column :attachments, :slug, :string
  end
end
