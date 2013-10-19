class ApplicationController < ActionController::Base
  before_filter :authenticate_admin!, only: [:new, :edit, :destroy, :update]

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # TODO: Consider changing your mind on NOT using decent_exposure for this app for educational purposes
  # While it's refreshing to be dealing with instance variables the way you have for this app, the cons 
  # are showing FAST :/ 
  protect_from_forgery with: :exception
end
