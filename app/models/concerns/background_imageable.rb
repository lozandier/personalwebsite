module BackgroundImageable 
  extend ActiveSupport::Concern 

  included do 
    
    has_attached_file :background_image, styles: {
      showcased: ["434x245#", :png], 
      showcased_retina_ready: ["868x488#{}", :png],
      as_a_background:["1562^", :png],
      as_a_background_retina_ready: ["3124^", :png]
   }

    validates_attachment :background_image, content_type: { content_type: ["image/jpeg", "image/png", "image/webp"] }
    validates_attachment_presence :background_image 

  end
end
