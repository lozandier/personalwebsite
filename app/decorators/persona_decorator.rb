class PersonaDecorator
  attr_reader :persona 

  include ActionView::Helpers


  def initialize(persona)
    @persona = persona 
  end

  def self.decorate_personas(personas)
    personas.map { |persona| new(persona) }
  end

  class << self 
    alias_method :build_collection, :decorate_personas
  end

  def respond_to_missing?(method, include_private=false)
    persona.respond_to?(method) || super 
  end

  def method_missing(method, *args, &blocks)
    persona.send(method, *args, &block)
  end

  def age 
    "#{persona.age} years old"
  end


  def description
    "#{persona.description}".html_safe
  end

  def test_method
    content_tag(:div, "#{persona.description}")
  end

  def test_method2
    content_tag(:div, "#{persona.creative_commons_attribution}")
  end

  def class_box      
      cc = "Attribution-ShareAlikeS"

      cc_class = case cc 
      when "Attribution-ShareAlike"
        "ShareAlike Man"
      else
        "Something else "
      end
       return content_tag :p, class: 'dragon', do 
         "#{cc_class}"
       end
      # case cc_class.to_s
      #   when 'Attribution-ShareAlike'
      #     'cc_sa'
      #   when 'Attribution-NoDerivs'
      #     'cc_nd'
      #   when 'Attribution-NonCommercial'
      #     'cc_nonc'
      #   when 'Attribution-NonCommercial-NoDerivs'
      #     'cc_nonc_nd'
      #   when 'Attribution-NonCommercial-ShareAlike'
      #     'cc_nonc_sa'
      #   else 
      #     "Nope"
      #   end

  end
end
