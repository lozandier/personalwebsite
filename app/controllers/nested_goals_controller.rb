class GoalsController < ApplicationController 
  #before_action :get_project
  before_action :set_up_goalable
  def new
    if params[:project_id] && params[:persona_id]
      get_persona
    elsif params[:project_id] && params[:client_id]
      get_client 
    elsif 
      get_persona 
    end
  end

  def create 
    @goalable.goals.new(goal_params)
  end

  def edit
    @goalable.goals.find(goal_id)
  end

  def update 

  end


  private 

  def get_persona
    get_project
    @project.find.personas.friendly.find(params[:persona_id])
  end

  def get_client  
    get_project
    @project.find.personas.friendly.find(params[:client_id])
  end

  def goal_params 
    params.require(:goal).permit(:copy)
  end

  def get_project
    @project = Project.friendly.find(params[:project_id])
  end

  def set_up_goalable
    # hard assumption = if you know the params are project_id and persona_id or client_id exists, @goalable is either one (2) 
    # otherwise, get @project and see if there's another params with the x_id pattern to set to @goalable 
      # if that's nil, @project IS the @goalable. 
    if params[:project_id] && params[:persona_id]
      @goalable = get_persona
    elsif params[:project_id] && params[:client_id]
      @goalable = get_client 
    elsif params[:project_id]
      @goalable = get_project 
    end
  end
end
