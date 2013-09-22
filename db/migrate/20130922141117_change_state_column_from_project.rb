class ChangeStateColumnFromProject < ActiveRecord::Migration
  def change
    change_column :projects, :state, :string, default: 'pending'
  end
end
