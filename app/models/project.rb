class Project < ActiveRecord::Base
  extend FriendlyId 

  friendly_id :title, use: [:slugged, :history]

  # Special initializers 
  has_attached_file :cover

  # validations 
  MEDIUM_TYPES = ["Website", "Interactive Document", "Graphic Design"]
  
  validates :title, :description, presence: true 
  validates_attachment :cover, content_type: { content_type: ["image/jpeg", "image/png", "image/webp"] }
  validates :medium, inclusion: { in: MEDIUM_TYPES }

  # Associations 
  has_many :photos
  has_many :personas
  has_many :identity_guidelines
  has_many :stages
  has_many :goals
  
  #has_many :testimonials
  has_many :technologies, through: :technology_profiles 
  has_many :technology_profiles 

  # State Machine 
  state_machine :state, initial: :pending do 
    event :approve do 
      transition any => :approved 
    end
  end

  def valid_technology_percentages? 
    technology_profiles.sum( :percentage_of_project) <= 100
  end
  
end
