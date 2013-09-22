class IdentityGuideline < ActiveRecord::Base
  belongs_to :project
  # validations 
  validates :brand_name, :overview, :description, presence: true 
  validates_attachment :brand_image, content_type: { content_type: ["image/jpg", "image/webp", "image/png"]}, size: {less_than: 5.megabyte }

end
