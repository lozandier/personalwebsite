class InfluencerValidator < ActiveModel::Validator 
  def validate(record)
    if record.persona.influencers.sum(:percentage) + record.percentage > 100.0
      record.errors[:percentage] << "the percentage value of this new influencer cannot cause the sum of all influencer associated with the Persona #{record.persona.full_name} to be above 100%. There's only 100- "
    end   
  end
end
