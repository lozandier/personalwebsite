class Persona < ActiveRecord::Base
  #special properties 
  has_attached_file :avatar  
  # validations 
  validates :first_name, :last_name, presence: true 
  validate_attachment :avatar, content_type: { content_type: ["image/jpg", "image/webp", "image/png"] }, size: { less_than: 5.megabyte }
  validates :age, numericality: { greater_than: 0, integer: true }
  validates :description, length: { minimum: 50 }
  validates :byline, length: { maximum: 140 }
  belongs_to :project
  has_many :influencers 
end
