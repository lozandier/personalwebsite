class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :main_image 
  has_many :technology_profiles 
  has_many :personas 
  #has_many :testimonials <TO:DO> 
  has_many :photos

  embed :ids, include: true 

  
end
