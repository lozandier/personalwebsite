class InfluencerValidator < ActiveModel::Validator 
  def validate(record)
    if record.new_record? 
      if record.persona.influencers.sum(:percentage) + record.percentage > 100.0
        record.errors[:percentage] << "the percentage value of this new influencer cannot cause the sum of all influencer associated with the Persona #{record.persona.full_name} to be above 100%. There's only #{100.0 - record.persona.influencers.sum(:percentage)}% available."
      end
    else
      if record.persona.influencers.where.not(name: record.name).sum(:percentage) + record.percentage > 100.0 
        record.errors[:percentage] << "the existing percentage value of #{record.name} cannot cause the sum of all influencer associated with the Persona #{record.persona.full_name} to be above 100%. There's only #{record.personas.influencers.where.not(influencer: record).sum(:percentage)}% available."
      end 
    end   
  end
end
