class GoalsController < ApplicationController 
  def new
    if params[:project_id] && params[:persona_id]
      fail 
    elsif params[:project_id] && params[:client_id]
    end
  end

  def create 
    
  end

  def edit
    
  end

  def update 
  end


  private 

  def get_goals 
    
  end

  def goal_params 

  end
end
