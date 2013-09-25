module NameConcern 
  extend ActiveSupport::Concern 

  included do 
    validates_each :first_name, :last_name do |record, attr, value|
      record.errors.add(attr, 'must start with uppercase to correctly register as a valid part of a name') if value =~ /\A[a-z]/
    end
  end

end
