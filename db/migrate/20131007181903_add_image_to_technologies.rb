class AddImageToTechnologies < ActiveRecord::Migration
  def change
    add_attachment :technologies, :image
  end
end
