class InterestsController < ApplicationController
  before_filter :authenticate_admin!, only: [:new, :edit, :destroy, :update]
  respond_to :json, :html 

  before_action :get_project
  before_action :get_persona 
  before_action :get_existing_interest, only: [:edit, :update, :destroy]

  def new 
    @interest = @persona.interests.new 
  end

  def create 
    @interest = @persona.interests.new(interest_params)

    if @interest.save 
      redirect_to project_persona_path(@project, @persona), notice: "Interest successfully added"
    else
      redirect_to :new  
    end 

  end

  def edit
    # get_existing_interest 
  end

  def update 
    if @interest.update(@interest_params)
      redirect_to project_persona_path(@project, @persona), notice: "Interest successfully added."
    else 
      render :edit 
    end 
  end

  def destroy 
    if @interest.destroy
      redirect_to project_persona_path(@project, @persona), notice: "Interest successfully deleted."
    else 
      redirect_to project_persona_path(@project, @persona), notice: "Interest could not be  deleted."
    end 
  end

  private 

  def get_project
    @project = Project.friendly.find(params[:project_id])
  end

  def get_persona
    @persona = Persona.friendly.find(params[:persona_id])
  end

  def get_existing_interest
    @interest = @persona.interests.find(params[:id])
  end

  def interest_params 
    params.require(:interest).permit(:name, :value)
  end
  
end
