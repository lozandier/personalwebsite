class Persona < ActiveRecord::Base

  #virtual attributes 
  attr_accessor :approve_persona, :unapprove_persona, :full_name

  #special configuration, properties, and actions 
  CREATIVE_COMMONS_ATTRIBUTION_LICENSES = %w(None Attribution-ShareAlike Attribution-NoDerivs Attribution-NonCommercial Attribution-NonCommercial-ShareAlike Attribution-NonCommercial-NoDerivs)
  has_attached_file :avatar  
  has_attached_file :background_image
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
  belongs_to :project
  has_many :influencers 
  has_many :interests 
  has_many :goals, as: :goalable

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

  # 9/25/13: Due to 'Stack to Deep', this view-only definition will be defined here instead
  # of being inside PersonaDecorator; will be removed immediately and shouldn't be too
  # relied on 

  def cc_class
    case creative_commons_license
      when 'Attribution-ShareAlike'
        'cc_sa'
      when 'Attribution-NoDerivs'
        'cc_nd'
      when 'Attribution-NonCommercial'
        'cc_nonc'
      when 'Attribution-NonCommercial-NoDerivs'
        'cc_nonc_nd'
      when 'Attribution-NonCommercial-ShareAlike'
        'cc_nonc_sa'
      end
  end 

end

