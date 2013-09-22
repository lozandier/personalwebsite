class CreateTestimonals < ActiveRecord::Migration
  def change
    create_table :testimonals do |t|
      t.text :statement
      t.references :client, index: true

      t.timestamps
    end
  end
end
