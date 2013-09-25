class RenameColumnsFromAttachments < ActiveRecord::Migration
  def change
    remove_attachment :attachments, :attachment
    add_attachment :attachments, :file 
  end
end
