class AddPersonaCountToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :personas_count, :integer, default: 0
  end
end
