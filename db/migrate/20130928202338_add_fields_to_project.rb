class AddFieldsToProject < ActiveRecord::Migration
  def change
    add_attachment :projects, :background_image
  end
end
