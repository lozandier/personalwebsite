class Technology < ActiveRecord::Base
  has_many :projects, through: :technology_profiles
  has_many :technology_profiles 
end
