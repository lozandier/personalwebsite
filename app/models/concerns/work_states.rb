module WorkStates
  extend ActiveSupport::Concern 
  included do 
    #self.send(:attr_accessor, )
    attr_accessor "approve_#{self.to_s.downcase}".to_sym, "unapprove_#{self.to_s.downcase}".to_sym
    state_machine :state, initial: :pending do 

      state :coming_soon 

      event :approve do 
        transition any => :approved 
      end

      event :not_approved do 
        transition any => :pending
      end
    end
  end

  def perform_state_change 
    self.state = 'approved' if "approve_#{self.class.to_s.downcase}".constantize == 1 
    self.state = 'pending' if "unapprove_#{self.class.to_s.downcase}".constantize == 1
  end

end
