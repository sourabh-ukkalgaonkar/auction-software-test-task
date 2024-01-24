# frozen_string_literal: true

# Class ApplicationController Parent class for all the controllers
class ApplicationController < ActionController::Base
  PER_PAGE = 2
  
  helper_method :current_user, :logged_in?

  def current_user
    User.find_by(id: session[:user_id])
  end

  def logged_in?
    !current_user.nil?
  end
end
