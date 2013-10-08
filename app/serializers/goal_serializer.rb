
class GoalSerializer < ActiveModel::Serializer
  attributes :id, :copy 

  has_one :goalable, polymorphic: true 
end

