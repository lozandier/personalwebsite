class Attachment < ActiveRecord::Base
  
  #validations 
  has_attached_file :file
  validates :name, :description,  presence: true
  validates :description, length: { minimum: 25 }
  validates_attachment_presence :file

  #special model properties  
  extend FriendlyId 
  friendly_id :name, use: [:slugged, :history]

  belongs_to :project

  def slug_candidates 
    [
      :name, 
      [:name, :created_at]
    ]
  end
  
end
