class TechnologyProfileValidator < ActiveModel::Validator
  def validate(record)
    if record.project.technology_profiles.sum(:percentage_of_project) + record.percentage_of_project > 100.0 
      record.errors[:percentage_of_project] << "the pecentage value provided cannot cause the sum of all influencer associated with this project (#{record.project.title}) to be over 100%"
    end
  end 
end
