class TechnologyProfile < ActiveRecord::Base
  belongs_to :project
  belongs_to :technology
end
