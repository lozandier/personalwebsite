class GoalsController < ApplicationController 
  #before_action :get_project
  def new
    @goalable = get_goalable 
  end

  def create 
    @goalable = get_goalable 
    @goal = @goalable.goals.build(goal_params)
    if @goal.save 
      if @goalable.respond_to?(:project) #had a case/when block using a different way before settling with this way with another if/else. 
        redirect_to eval("project_#{@goalable.class.to_s.downcase}_path(@goalable.project, @goalable)")
      else 
        redirect_to @goalable, notice: "Goal successfully added" #redirecting using @goalable
      end
    else 
      render :new 
    end 
  end

  def edit
    @goalable.goals.find(goal_id)
  end

  def update 

  end


  private 

  def get_goals 
    
  end
  def goal_params 
    params.require(:goal).permit(:copy)
  end


  def get_goalable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        # in my case, 'friendly' worthy models will be worked on 
        return $1.classify.constantize.friendly.find(value) 
      end
    end
    nil 
  end
end
