class PersonaDecorator < Draper::Decorator 
  include Draper::LazyHelpers 
  decorates_finders
  delegate_all

  ## 9/30/13 Transitioned to Draper 

  #include ActionView::Helpers


  # def initialize(persona)
  #   @persona = persona 
  # end

  # def self.decorate_personas(personas)
  #   personas.map { |persona| new(persona) }
  # end

  # class << self 
  #   alias_method :build_collection, :decorate_personas
  # end

  # def respond_to_missing?(method, include_private=false)
  #   persona.respond_to?(method) || super 
  # end

  # def method_missing(method, *args, &blocks)
  #   persona.send(method, *args, &block)
  # end

  def age 
     "#{persona.age} years old"
  end


  def description
    # Feels so good to have proper typography here 
    markdown.render(persona.description)
  end

  

  def class_box      
    cc_class = case creative_commons_license
      when 'Attribution-ShareAlike'
        'cc_sa'
      when 'Attribution-NoDerivs'
        'cc_nd'
      when 'Attribution-NonCommercial'
        'cc_nonc'
      when 'Attribution-NonCommercial-NoDerivs'
        'cc_nonc_nd'
      when 'Attribution-NonCommercial-ShareAlike'
        'cc_nonc_sa'
      else 
        "Nope"
      end
    return cc_class
  end
end
