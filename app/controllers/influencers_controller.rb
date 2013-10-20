class InfluencersController < ApplicationController 
  before_filter :authenticate_admin!, only: [:new, :edit, :destroy, :update]
  respond_to :json, :html 

  before_action :get_project
  before_action :get_persona 
  before_action :get_existing_influencer, only: [:edit, :update, :destroy]

  def new
    @influencer = @persona.influencers.new 
  end

  def create 
    @influencer = @persona.influencers.new(influencer_params)
    if @influencer.save 
      redirect_to project_persona_path(@project, @persona), notice: "Influencer properly saved."
    else 
      render :new 
    end 
  end

  def update
    if @influencer.update(influencer_params)
      redirect_to project_persona_path(@project, @persona), notice: "Influence properly updated."
    else
      render :edit
    end
  end

  def edit
  end

  def destroy
    if @influencer.destroy
      redirect_to project_persona_path(@project, @persona), notice: "Influence properly  deleted."
    else 
      redirect_to project_persona_path(@project, @persona), notice: "Influence could not be deleted."
    end
  end

  private 

  def get_project
    @project = Project.friendly.find( params[:project_id] )
  end
 
  def get_persona
    @persona = @project.personas.friendly.find( params[:persona_id] )
  end

  def get_existing_influencer 
    @influencer = @persona.influencers.find( params[:id] )
  end

  def influencer_params
    params.require(:influencer).permit(:name, :percentage)
  end
 
end
