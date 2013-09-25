class Goal < ActiveRecord::Base
  belongs_to :goalable, polymorphic: true 
  validates :goalable, presence: true 
end
