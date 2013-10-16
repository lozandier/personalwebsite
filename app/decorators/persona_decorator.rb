class PersonaDecorator < ApplicationDecorator  
  include Draper::LazyHelpers 
  decorates_finders
  delegate_all

  ## 9/30/13 Transitioned to Draper 

  #include ActionView::Helpers


  # def initialize(persona)
  #   @persona = persona 
  # end

  # def self.decorate_personas(personas)
  #   personas.map { |persona| new(persona) }
  # end

  # class << self 
  #   alias_method :build_collection, :decorate_personas
  # end

  # def respond_to_missing?(method, include_private=false)
  #   persona.respond_to?(method) || super 
  # end

  # def method_missing(method, *args, &blocks)
  #   persona.send(method, *args, &block)
  # end

  def age 
     "#{persona.age} years old"
  end

  def image  
    link_to image_tag(avatar.url(:thumbnail), alt: full_name, data: {interchange: "[#{avatar.url(:thumbnail_retina_ready)}, (retina)]"}), project_persona_path(persona.project, persona), itemprop: 'relatedLink', "data-no-turbolink" => true 
  end

  def spotlight_image
    image_tag avatar.url(:thumbnail), alt: full_name, data: {interchange: "[#{avatar.url(:thumbnail_retina_ready)}, (retina)]"}, itemprop: 'primaryImageOfPage image url'
  end

  def byline 
    markdown.render(object.byline)
  end


  def description
    # Feels so good to have proper typography here 
    markdown.render(object.description).html_safe
  end

  #TODO: Will abstract this for future, inevitable attributes to keep me DRY
  def display_associated_collection(collection)
    empty_message = 
    # If they're equal and it can be read, it's valid; can wrap this into a if class with the latter, but nah.
      if influencers == collection #&& read_attribute(collection)
        'There is no data regarding influencers for this persona'
      elsif interests == collection #&& read_attribute(collection)
        'There is no data regarding interests for this persona (yet).'
      end
      if collection.any?
        return render collection 
      else
        #fail
        content_tag(:p, empty_message)
        "#{empty_message}"
      end
  end

  def display_goals(goal_collection)
    if goal_collection.any?
      render goal_collection #partial: 'shared/list_goals', collection: object.goals, as: :goal
    else
      "This persona had no goals or it wasn't applicable or this particular persona. "
    end
  end

  def copyright_meta
    if creative_commons_license.downcase != 'none'
        a = []
        a << (tag :meta, itemprop: "copyrightHolder accountablePerson creator", content: "#{creative_commons_attribution}") 
        a <<  (tag :meta, itemprop: "educationalUse", content: "prototyping")
        a.join.html_safe
    end
  end
  

  def display_attribution      
    if creative_commons_license.downcase != 'none' 
      cc_class = case creative_commons_license
        #note: using the conventions of the actual files 
        when 'Attribution'
          'cc-by'
        when 'Attribution-ShareAlike'
          'cc-by-sa'
        when 'Attribution-NoDerivs'
          'cc-by-nd'
        when 'Attribution-NonCommercial'
          'cc-by-nc'
        when 'Attribution-NonCommercial-NoDerivs'
          'cc-by-nc-nd'
        when 'Attribution-NonCommercial-ShareAlike'
          'cc-by-nc-sa'
        else 
          "Nope"
        end
      a = []
      content_tag :article, class: "cc_attribution" do 
        
        a << (content_tag :figure, class: "cc_attribution_badge #{cc_class}" do 
        end )

        a << (content_tag :a, href: "#{creative_commons_attribution_link}", class: 'large-8 columns cc_attribution_explanation' do
          markdown.render(creative_commons_attribution).html_safe 
        end)
        a.join.html_safe 
     end
    end
  end


  def admin_links 
    content_tag :div, class: 'admin_links ' do 
      concat link_to 'Edit Persona', edit_project_persona_path(persona.project, persona)
      concat link_to 'Add Influencer', new_project_persona_influencer_path(persona.project, persona)
      concat link_to 'Add Interest', new_project_persona_interest_path(persona.project, persona)
      concat link_to 'Add Goal', new_persona_goal_path(persona)
      concat link_to 'Delete Persona', project_persona_path(persona.project, persona), method: :delete, data: { confirm: "Are you sure "}
    end
  end




end
