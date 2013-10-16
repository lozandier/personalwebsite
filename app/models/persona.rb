class Persona < ActiveRecord::Base
  include BackgroundImageable 
  default_scope includes(:interests, :influencers).order(:first_name)
  #virtual attributes 
  attr_accessor :approve_persona, :unapprove_persona, :full_name

  #special configuration, properties, and actions 
  CREATIVE_COMMONS_ATTRIBUTION_LICENSES = %w(None Attribution Attribution-ShareAlike Attribution-NoDerivs Attribution-NonCommercial Attribution-NonCommercial-ShareAlike Attribution-NonCommercial-NoDerivs)
  
  has_attached_file :avatar, styles: {
    thumbnail: "279x279#",
    thumbnail_retina_ready: "558x558#"
  }
  extend FriendlyId 
  friendly_id :slug_candidates, use: [:slugged, :history]

  # call backs 
  before_save :perform_state_change
  include NameConcern

  # validations 
  validates :first_name, :last_name, presence: true 
  validates_attachment :avatar, content_type: { content_type: ["image/jpeg", "image/webp", "image/png"] }, size: { less_than: 5.megabyte }
  validates :age, numericality: { greater_than: 0, integer: true }
  validates :description, length: { minimum: 50 }
  validates :byline, length: { maximum: 140 }
  #validates :project, presence: true 
  validates_with CreativeCommonsValidator

  #associations
  belongs_to :project, counter_cache: true, touch: true  
  has_many :influencers, dependent: :destroy 
  has_many :interests, dependent: :destroy 
  has_many :goals, as: :goalable, dependent: :destroy 

  # state_machine 
  state_machine :state, initial: :pending do 
    state :approved 
    state :coming_soon
  end

  def full_name 
    "#{first_name} #{last_name}"
  end

  def slug_candidates 
    [
      :full_name, 
      [:full_name, :age],
      [:full_name, :occupation, :age]
    ]
  end


  def perform_state_change 
    self.state = 'approved' if approve_persona == '1' 
    self.state = 'pending' if unapprove_persona == '1'
  end

  

end

