class ProjectsController < ApplicationController
  before_filter :authenticate_admin!, only: [:new, :edit, :destroy, :update]

  #special parameter
  respond_to :json, :html 

  #special action
  before_action :get_project, only: [:edit, :update, :destroy ]
  
  def index
    @most_showcased_skills  = Technology.where('projects_count > ?', 0).order(projects_count: :desc).decorate
    @projects = Project.all.decorate
    respond_with @projects
  end

  def show
    @project = ProjectDecorator.new( get_project )
    @personas = @project.personas
    @attachments = @project.attachments 
    @goals = @project.goals 
    @photos = @project.photos
    @technology_profiles = @project.technology_profiles
    respond_to do | format | 
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
    rescue ActiveRecord::StaleObjectError
      flash[:alert] = "Project was updated somewhere else"
      redirect_to [:edit, @project] 
  end

  def destroy
    @project.destroy
    redirect_to projects_path, notice: "Project successfully deleted."
  end


  private 

  def project_params
    params.require(:project).permit(:title, :byline, :medium, :state, :main_image, :background_image, :description, :url, :missing_url_reason, :experiment, :released_on, :approve_project, :unapprove_project, :lock_version) 
  end

  def get_project
    @project = Project.includes(:personas, :attachments, :goals, :photos, :technology_profiles, :technologies).friendly.find(params[:id])
  end

end
