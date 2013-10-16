class TechnologyProfile < ActiveRecord::Base
  validates :percentage_of_project, presence: true 
  belongs_to :project
  belongs_to :technology
  validates :project_id, uniqueness: {scope: :technology_id } #Can only be one project associated with a technology among this entire collection :) Smart thinking, Kev!
  validates_with TechnologyProfileValidator 
end
