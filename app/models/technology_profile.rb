class TechnologyProfile < ActiveRecord::Base
  validates :percentage_of_project, presence: true 
  belongs_to :project
  belongs_to :technology
  validates_with TechnologyProfileValidator 
end
