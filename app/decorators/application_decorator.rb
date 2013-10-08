class ApplicationDecorator < Draper::Decorator 
  def class_for_object_amount(collection)    
      "odd" if collection.size.odd?
  end
end
