class Technology < ActiveRecord::Base
  
  #Special Initialization 
  has_attached_file :image, default_url: '/images/missing.png', styles: {
    thumbnail: "279x279#",
    thumbnail_retina_ready: "558x558#"
  }

  extend FriendlyId 
  friendly_id :name, use: [:slugged, :history]

  #validation
  validates :name, :color, :personal_history, :byline, presence: true 
  validates :byline, length: { maximum: 90 }

  #association
  has_many :projects, through: :technology_profiles, counter_cache: true
  has_many :technology_profiles, dependent: :destroy 
end
