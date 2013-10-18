class ChangeCopyToTextFromGoals < ActiveRecord::Migration
  def change
    change_column :goals, :copy, :text
  end
end
