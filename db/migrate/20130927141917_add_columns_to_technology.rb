class AddColumnsToTechnology < ActiveRecord::Migration
  def change
    add_column :technologies, :personal_history, :text
    add_column :technologies, :years_of_experience, :integer
  end
end
