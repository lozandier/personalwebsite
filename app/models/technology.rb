class Technology < ActiveRecord::Base
  #validation
  validates :name, :color, presence: true 
  #association
  has_many :projects, through: :technology_profiles, counter_cache: true
  has_many :technology_profiles 
end
