class Goal < ActiveRecord::Base
  belongs_to :goalable, polymorphic: true, touch: true 
  validates :goalable, presence: true 
end
