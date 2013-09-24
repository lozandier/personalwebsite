class Influencer < ActiveRecord::Base
  validates :name, :percentage, presence: true 
  #validates :personas, :not_above_100
  #associations 
  belongs_to :persona

  def not_above_100(value)
    persona.influencers.sum(:percentage) + value < 100
  end
end
