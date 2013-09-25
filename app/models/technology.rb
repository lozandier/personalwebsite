class Technology < ActiveRecord::Base
  #validation
  validates :name, :color, presence: true 
  #association
  has_many :projects, through: :technology_profiles
  has_many :technology_profiles 
end
