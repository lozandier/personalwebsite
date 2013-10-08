
class PersonaSerializer < ActiveModel::Serializer
  attributes :id

  has_many :interests 
  
  has_many :influencers

  has_many :goals, polymorphic: true 
  embed :ids, include: true 
end

