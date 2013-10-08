class Influencer < ActiveRecord::Base
  #validations 
  validates :name, :percentage, :persona, presence: true 
  validates :percentage, numericality: { less_than_or_equal_to: 100}
  validates_with InfluencerValidator
  #associations 
  belongs_to :persona

  def not_above_100(value)
    persona.influencers.sum(:percentage) + value < 100
  end
  
end
