class Photo < ActiveRecord::Base
  has_attached_file :image
  validates :caption, presence: true
  belongs_to :project
end
