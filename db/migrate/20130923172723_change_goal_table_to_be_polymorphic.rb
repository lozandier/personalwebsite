class ChangeGoalTableToBePolymorphic < ActiveRecord::Migration
  def change
    remove_column :goals, :project_id 
    add_column :goals, :goalable_id, :integer, index: true
    add_column :goals, :goalable_type, :string 
  end
end
