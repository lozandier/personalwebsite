class RenameCoverFieldFromProjects < ActiveRecord::Migration
  def change
    remove_attachment :projects, :cover
    add_attachment :projects, :main_image
  end
end
