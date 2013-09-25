class PersonaDecorator
  attr_reader :persona 
  include ActionView::Helpers


  def initialize(persona)
    @persona = persona 
  end

  def respond_to_missing?(method)
    persona.respond_to_missing?(method)
  end

  def method_missing(method, *args, &blocks)? 
    persona.send(method, *args, &block)
  end

  def age 
    "#{age} years old"
  end


  def description
    "#{persona.description}".html_safe
  end


end
