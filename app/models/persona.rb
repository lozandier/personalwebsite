class Persona < ActiveRecord::Base

  #virtual attributes 
  attr_accessor :approve_persona, :unapprove_persona, :full_name

  #special configuration, properties, and actions 
  has_attached_file :avatar  
  has_attached_file :background_image
  extend FriendlyId 
  friendly_id :slug_candidates, use: [:slugged, :history]

  # call backs 
  before_save :perform_state_change

  # validations 
  validates :first_name, :last_name, presence: true 
  validates_attachment :avatar, content_type: { content_type: ["image/jpeg", "image/webp", "image/png"] }, size: { less_than: 5.megabyte }
  validates :age, numericality: { greater_than: 0, integer: true }
  validates :description, length: { minimum: 50 }
  validates :byline, length: { maximum: 140 }

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

end
