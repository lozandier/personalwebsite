class AddOptimisticLockingToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :lock_version, :integer, default: 0 
  end
end
