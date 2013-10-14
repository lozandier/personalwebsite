

class PhotoDecorator < ApplicationDecorator
  include Draper::LazyHelpers 
  decorates_finders
  delegate_all

  def regular_image
    link_to( image_tag(image.url(:thumbnail), 
      data: {"image-caption" => "#{caption.presence || %(Photo is part of #{project.title})}", 
      interchange: "[#{image.url(:thumbnail_retina_ready)}, (retina)]"}), 
      asset_url(image.url), itemprop: 'relatedLink image', 
      data: {"fresco-group" => photo.project.title, "fresco-options" => "ui: 'inside', fit: 'height'" }, class: 'fresco')
  end


  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

end

