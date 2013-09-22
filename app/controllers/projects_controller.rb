class ProjectsController < ApplicationController
  respond_to :json, :html 
  #before_action :get_project, only: [:create ]
  
  def index
    @projects = ProjectDecorator.decorate_projects(Project.all)
  end

  def show
    @project = ProjectDecorator.new( Project.find(params[:id]) )
  end

  def new 
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      redirect_to projects_path, notice: "Project successfully created"
    else
      render :new 
    end
  end

  def edit

  end

  def update

  end

  def destroy
    
  end


  private 

  def project_params
    params.require(:project).permit(:title, :medium, :state, :cover, :description) 
  end
end
