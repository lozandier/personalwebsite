class ProjectsController < ApplicationController

  #special parameter
  respond_to :json, :html 

  #special action
  before_action :get_project, only: [:edit, :update ]
  
  def index
    @projects = ProjectDecorator.decorate_projects(Project.all)
    respond_with @projects
  end

  def show
    @project = ProjectDecorator.new( get_project )
    respond_to do |format| 
      format.html { respond_with @project }
      format.json { respond_with @project.project }
    end
  end

  def new 
    @project = Project.new
  end

  def create
    
    @project = Project.new(project_params)
    #@approve_project = params[:approve_project] 
    if @project.save 
      redirect_to projects_path, notice: "Project successfully created"
    else
      render :new 
    end

  end

  def edit

  end

  def update
    if @project.update(project_params)
      redirect_to project_path, notice: "Project Successfullly Updated" 
    else
      render :edit 
    end 
  end

  def destroy
    
  end


  private 

  def project_params
    params.require(:project).permit(:title, :medium, :state, :cover, :description, :approve_project, :unapprove_project) 
  end

  def get_project
    @project = Project.friendly.find(params[:id])
  end

end
