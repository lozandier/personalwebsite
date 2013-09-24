class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :cover 
  has_many :technology_profiles 
  has_many :personas 
  #has_many :testimonials 
  #has_many :photos

  embed :ids, include: true 
end
