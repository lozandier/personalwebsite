class ProjectDecorator 
  attr_reader :project 

  include ActionView::Helpers 

  def initialize(project)
    @project = project 
  end

  def self.decorate_projects(projects)
    projects.map { |project| new(project)}
  end

  class << self 
    alias_method :build_collection, :decorate_projects
  end

  # Proper Delegation 
  def method_missing(method, *args, &block)
    project.send(method, *args, &block)
  end

  def respond_to_missing?(method)
    project.respond_to?(method) || super 
  end

  def to_params
    project
  end

end
