# frozen_string_literal: true

# SessionController class used to handle the sign-in, sign-out 
class SessionsController < ApplicationController
  before_action :check_active_session, only: %i[new create]

  def new; end

  def create
    @user = User.find_by(username: params[:username])

    if @user&.authenticate?(params[:password])
      session[:user_id] = @user.id
      redirect_to projects_path, notice: 'You have been succesfully login'
    else
      @error = true
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to projects_path, notice: 'You have been succesfully logout from the system'
  end

  private

  def check_active_session
    redirect_to root_path if current_user.present?
  end
end
