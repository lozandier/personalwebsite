
class PhotoSerializer < ActiveModel::Serializer
  attributes :id, :caption, :image_url

  def image_url
    object.image.url
  end

end

