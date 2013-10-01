class SourceValidator < ActiveModel::Validator 
  def validate(record)
    if record.missing_url_reason.blank? && record.url.blank? 
      record.errors[:base] << "must have a reason for the project url being blank."
    end
  end
end  
