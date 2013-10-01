class ProjectDecorator < Draper::Decorator 
  include Draper::LazyHelpers 
  decorates_finders
  delegate_all 

   

  decorates_associations :personas

   

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

  def display_goals
    if goals.any?  
      render 'shared/goal_list', object: goals
    else 
      content_tag(:strong, "This Project doesn't have goals, or it wasn't applicable for this particular project to have goals.", class: 'empty_content')
    end
  end

  def test_method_state
    "#{state}"
  end

  def test_method_state2
    "#{project.state}"
  end

  def display_personas
    if personas.any?
      render personas
    else
      content_tag :strong, "This project currently doesn't have personas associated with it.", class: "empty_content"
    end

  end

  def display_attachments
    if attachments.any?
      render attachments
    else
      content_tag :strong, "This project currently doesn't have personas associated with it.", class: "empty_content"
    end

  end

  


end
