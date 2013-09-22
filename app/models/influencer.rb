class Influencer < ActiveRecord::Base
  validates :name, :percentage, presence: true 
end
