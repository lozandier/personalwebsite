
class PersonaSerializer < ActiveModel::Serializer
  attributes :id

  has_many :interests 
  
  has_many :influencers
  embed :ids, include: true 
end

