class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.references :project, index: true
      t.string :copy

      t.timestamps
    end
  end
end
