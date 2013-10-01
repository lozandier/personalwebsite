class CreativeCommonsValidator < ActiveModel::Validator 
  def validate(record)
    if record.creative_commons_license.downcase != "none" || record.creative_commons_license.nil? 
      if record.creative_commons_attribution.blank? || record.creative_commons_attribution_link.blank? 
        record.errors[:base] << "name and link to original owner of copyright work attached for this record incorrectly done."
      end
    end
  end
end 
