class Interest < ActiveRecord::Base
  validates :name, presence: true 
  validates :value, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5, integer: true,}
  belongs_to :persona
end
