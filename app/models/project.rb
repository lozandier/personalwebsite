class Project < ActiveRecord::Base

  #virtual attributes 
  attr_accessor :approve_project, :unapprove_project


  #business-level scopes 
  
  #default_scope { Project.approved }
  scope :approved, -> {where(state: :approved).order(created_at: :desc)} 
  scope :recent, -> {where('created_at > ?', 1.month.ago )}

  
  #special actions 
  before_save :perform_state_change

  extend FriendlyId 

  friendly_id :title, use: [:slugged, :history]

  # Special initializers 
  has_attached_file :cover

  # validations 
  MEDIUM_TYPES = ["Website", "Interactive Document", "Graphic Design", "iPhone App"]
  
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

    state :coming_soon 

    event :approve do 
      transition any => :approved 
    end

    event :not_approved do 
      transition any => :pending
    end
  end

  def valid_technology_percentages? 
    technology_profiles.sum( :percentage_of_project) <= 100
  end

  def perform_state_change 
    self.state = 'approved' if approve_project == '1' 
    self.state = 'pending' if unapprove_project == '1'
  end

end
