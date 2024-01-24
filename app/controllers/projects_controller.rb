# frozen_string_literal: true

# ProjectsController class used to handle the projects
class ProjectsController < ApplicationController
  before_action :fetch_projects, only: :index

  def index
    respond_to do |format|
      format.html
      format.js
    end
  end

  private

  def fetch_projects
    @projects = if current_user.present?
                  Project
                    .custom_order(params[:sort_by])
                    .paginate(page: params[:page], per_page: PER_PAGE)
                else
                  []
                end
  end
end
