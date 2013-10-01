class AttachmentDecorator 

  attr_reader :attachment 
  
  include ActionView::Helpers 


  def initialize(attachment)
    @attachment = attachment 
  end

  def self.decorate_attachments(attachments)
    attachments.map {|attachment| new(attachment)}
  end

  class << self 
    alias_method :build_collection, :decorate_attachments 
  end

  def method_missing(method, *args, &block)
    attachment.send(method, *args, &block)
  end

  def respond_to_missing?(method)
    attachment.respond_to?(method) || super 
  end

  def file_icon_class
    case attachment.file_content_type
      when 'application/pdf'
        ".pdf"
      when 'text/ruby' || 'text/rb'
        ".rb"
      when "text/html"
        ".html"
      when "text/coffee"
        ".coffee"
      else 
        ".other"
      end
    # just to be explicit with my intentions here  
    
  end



end
