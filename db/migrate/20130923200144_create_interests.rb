class CreateInterests < ActiveRecord::Migration
  def change
    create_table :interests do |t|
      t.references :persona, index: true
      t.string :name
      t.integer :value, default: 0
      t.timestamps
    end
  end
end
