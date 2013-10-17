module ApplicationHelper
  def title(title)
    content_for :title, title 
  end

  def description(description)
    content_for :description, description
  end


  def flash_class(type)
    case type
    when :alert
      "alert-error"
    when :notice
      "alert-success"
    else
      ""
    end
  end
  
end
