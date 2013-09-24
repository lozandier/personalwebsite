
class TechnologyProfileSerializer < ActiveModel::Serializer
  attributes :id, :name, :color, :percentage_of_project

  def name 
    object.technology.name 
  end

  def color 
    object.technology.color 
  end


end

