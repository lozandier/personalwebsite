class TechnologyProfilesController < ApplicationController
  respond_to :json, :html 
  
  before_action :set_project, only: [:new, :create, :edit, :update, :destroy]
  before_action :get_technology_profile, only: [:edit, :update, :destroy ]

  def new
    @technology_profile = @project.technology_profiles.new 
  end

  def create
    @technology_profile = @project.technology_profiles.new(technology_profile_params)
    if @technology_profile.save
      redirect_to project_path(@project), notice: "Technology profile successfully added"
    else
      render :new 
    end 
  end

  def edit
    @technology_profile = @project.technology_profiles.find(params[:id])
  end

  def update 
    @technology_profile = @project.technology_profiles.find(params[:id])
    if @technology_profile.update(technology_profile_params)
      redirect_to project_path(@project), notice: "Technology profile successfully updated"
    else
      render :edit 
    end
  end

  def destroy

  end

  private 

  def set_project
    @project = Project.friendly.find(params[:project_id])
  end

  def get_technology_profile 
    @technology_profile = @project.technology_profiles.find(params[:id])
  end

  def technology_profile_params 
    params.require(:technology_profile).permit(:technology_id, :percentage_of_project)
  end
end
