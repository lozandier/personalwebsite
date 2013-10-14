class Photo < ActiveRecord::Base
  
  has_attached_file :image, styles: {
    thumbnail: ["343x343", :jpeg],
    thumbnail_retina_ready: ["686x686", :jpeg] 
  }

  validates_attachment_presence :image
  validates :caption, presence: true
  belongs_to :project, touch: true 
end
