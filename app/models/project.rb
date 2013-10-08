class Project < ActiveRecord::Base
  include WorkStates
  include BackgroundImageable
  
  #virtual attributes 
  attr_accessor :approve_project, :unapprove_project


  #business-level scopes 
  
  #default_scope { Project.approved }
  default_scope { includes(:personas, :attachments, :goals, :photos, :technology_profiles).order(created_at: :desc) }
  scope :approved, -> {where(state: :approved).order(created_at: :desc)} 
  scope :recent, -> {where('created_at > ?', 1.month.ago )}

  
  #special actions 
  before_save :perform_state_change

  extend FriendlyId 

  friendly_id :title, use: [:slugged, :history]

  # Special initializers 
  has_attached_file :main_image, styles: {
    thumbnail: "279x279#",
    thumbnail_retina_ready: "558x558#"
  }


  # validations 
  MEDIUM_TYPES = ["Website", "Interactive Document", "Graphic Design", "iPhone App"] 
  validates :title, :description, :released_on, presence: true 
  validates :medium, inclusion: { in: MEDIUM_TYPES }
  validates :experiment, inclusion: { in: [true, false] }
  validates :url, url: true, if: 'missing_url_reason.blank?'
  validates :byline, length: {maximum: 90}
  validates_attachment :main_image, content_type: { content_type: ["image/jpeg", "image/png", "image/webp"] }
  validates_attachment_presence :main_image 
  validates_with SourceValidator #Since it's critical to protect my rearend, I'll always keep it on without an if clause or unless clause :) 
  
  # Associations 
  has_many :photos, dependent: :destroy 
  has_many :personas, counter_cache: true  
  has_many :identity_guidelines
  has_many :stages
  has_many :goals, as: :goalable
  has_many :attachments, dependent: :destroy 
  #has_many :testimonials
  has_many :technologies, through: :technology_profiles, counter_cache: :projects_count
  has_many :technology_profiles, dependent: :destroy 

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
