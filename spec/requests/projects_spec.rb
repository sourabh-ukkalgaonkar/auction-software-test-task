# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Projects', type: :request do
  let(:user) { create(:user) }
  let(:sort_by) do
    { category_name: 'category_name', username: 'username', title: 'title', recent_projects: 'recent_projects' }
  end

  describe 'GET /index' do
    before(:each) do
      allow_any_instance_of(ApplicationController)
        .to receive(:current_user)
        .and_return(user)
    end

    it 'should render project list page' do
      FactoryBot.create_list(:project, 3)
      get projects_path

      expect(response.status).to be(200)
      expect(assigns(:projects)).not_to be_nil
    end

    it 'Sort project by default' do
      FactoryBot.create_list(:project, 3)
      get projects_path

      expect(assigns(:projects).first).to eq(Project.order(created_at: :desc).first)
    end

    it 'Sort projects by category_name' do
      FactoryBot.create_list(:project, 3)
      get projects_path, params: { sort_by: sort_by[:category_name] }

      expect(assigns(:projects).first).to eq(Project.custom_order(sort_by[:category_name]).first)
    end

    it 'Sort projects by username' do
      FactoryBot.create_list(:project, 3)
      get projects_path, params: { sort_by: sort_by[:username] }

      expect(assigns(:projects).first).to eq(Project.custom_order(sort_by[:username]).first)
    end

    it "Sort projects by project's title" do
      FactoryBot.create_list(:project, 3)
      get projects_path, params: { sort_by: sort_by[:title] }

      expect(assigns(:projects).first).to eq(Project.custom_order(sort_by[:title]).first)
    end

    it 'Sort projects by project creation date' do
      FactoryBot.create_list(:project, 3)
      get projects_path, params: { sort_by: sort_by[:recent_projects] }

      expect(assigns(:projects).first).to eq(Project.custom_order(sort_by[:recent_projects]).first)
    end
  end
end
