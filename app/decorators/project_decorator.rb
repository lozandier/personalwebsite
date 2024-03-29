class ProjectDecorator < ApplicationDecorator  
  include Draper::LazyHelpers 
  decorates_finders
  delegate_all 
  decorates_associations :personas, :technologies, :photos

   

  #include ActionView::Helpers 
  

  # attr_reader :project 


  # def active_model_serializer
  #   ProjectSerializer
  # end

  # 9/30/2013 - Draper now is responsible. 
  # def initialize(project)
  #   @project = project 
  # end

  # def self.decorate_projects(projects)
  #   projects.map { |project| new(project)}
  # end
  # class << self 
  #   alias_method :build_collection, :decorate_projects
  # end

  # # Proper Delegation 
  # def method_missing(method, *args, &block)
  #   project.send(method, *args, &block)
  # end

  # def respond_to_missing?(method, include_private=false)
  #   project.respond_to_missing?(method) || super 
  # end

  # def is_decorated? 
  #   kind_of?(ProjectDecorator) 
  # end


  def description
    markdown.render(object.description).html_safe
  end

  def item_image  
    link_to( image_tag(background_image.url(:showcased), data: {interchange: "[#{background_image.url(:showcased_retina_ready)}, (retina)]"}), project_path(project), itemprop: 'relatedLink', "data-no-turbolink" => true )
  end


  def related_item_image 
     link_to( image_tag(main_image.url(:thumbnail), data: {interchange: "[#{main_image.url(:thumbnail_retina_ready)}, (retina)]"}), project_path(project), itemprop: 'relatedLink', "data-no-turbolink" => true )
  end

  def spotlight_image 
    image_tag main_image.url(:thumbnail), data: {interchange: "[#{main_image.url(:thumbnail_retina_ready)}, (retina)]"}, itemprop: 'primaryImageOfPage image url'
  end

  def display_goals
    if goals.any?  
      render goals
    else 
      content_tag(:p, "This Project doesn't have goals, or it wasn't applicable for this particular project to have goals.", class: 'empty_content')
    end
  end




  def display_personas
    if personas.any?
      render personas
    elsif experiment 
      content_tag :p, "This project being an experiment, personas weren't neceessarily applicable"
    else
      content_tag :p, "This project currently doesn't have personas associated with it.", class: "empty_content"
    end

  end

  def display_attachments
    if attachments.any?
      render attachments
    else
      content_tag :p, "This project currently doesn't have personas associated with it.", class: "empty_content"
    end
  end

  def display_byline
    byline.blank? ? content_tag(:p, medium) : content_tag(:p, byline, itemprop: "alternativeHeadline description") 
  end

  def display_byline_as_subheader 
    byline.blank? ? content_tag(:p, medium) : content_tag(:p, byline, itemprop: "alternativeHeadline description" )
  end

  

  # Needed to be dry, with the above collections most likely to have special code, I've seperated fom the function below 

  def display_associated_collection(collection)
    empty_message = 
    # If they're equal and it can be read, it's valid; can wrap this into a if class with the latter, but nah.
      if technology_profiles  == collection #&& read_attribute(collection)
        "This project doesn't have a technology profile generated (yet)."
      elsif photos == collection #&& read_attribute(collection)
        'No photos regarding this project are  available.'
      end

      if collection.any?
        return render collection 
      else
        return content_tag(:p, empty_message)
      end

  end


  def admin_links
    content_tag :div, class: 'admin_links ' do 
      concat link_to 'Edit Project', edit_project_path(project)
      
      concat link_to 'New Technology Profile', new_project_technology_profile_path(project)

      concat link_to 'New Personas', new_project_persona_path(project)

      concat link_to 'New Attachment', new_project_attachment_path(project)

      concat link_to 'Add Goals', new_project_goal_path(project)

      concat link_to 'Add Photos', new_project_photo_path(project)

      concat link_to 'Delete Project', project_path(project), method: :delete, data: { confirm: "Are you sure you wnat to delete this project?" }
    end
  end


  def released_since
    "#{time_ago_in_words(released_on)} ago".titleize
  end

  def display_experiment_badge  
      content_tag(:div, 'Experiment', class: 'experiment' ) unless experiment == false 
  end

  def display_project_link
    if url.blank? 
      content_tag :p, missing_url_reason
    else
      link_to 'Project can be found here', url
    end
  end


  def photo_edge_case_classes
    if photos.any? 
      if photos.size == 1
        "edge-case"
      elsif photos.size.even? && photos.size % 3 != 0 
        "even-out"
      end
    end
  end




end
