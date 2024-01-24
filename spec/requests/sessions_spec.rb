require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  let(:password) { Faker::Internet.password }
  let(:user) { create(:user, password: password) }

  describe "GET /login" do
    it "should render Sign In page" do
      get login_path
      expect(response).to render_template(:new)
      expect(response.status).to be(200)
    end
  end

  describe "POST /login" do
    it "should signin the user" do 
      post login_path, params: { username: user.username, password: password  }

      expect(assigns(:error)).to be_nil
      expect(response).to redirect_to(root_path)
    end

    it "should not signin user if password is wrong" do
      post login_path, params: { username: user.username, password: Faker::Internet.password  }
    
      expect(assigns(:error)).not_to be_nil
      expect(response).to render_template(:new)
    end

    it "should not signin user if username is wrong" do
      post login_path, params: { username: Faker::Internet.username, password: password }
    
      expect(assigns(:error)).not_to be_nil
      expect(response).to render_template(:new)
    end
  end

  describe "DELET /logout" do
    it "should logout the user" do
      delete logout_path

      expect(response).to redirect_to(root_path)
    end
  end
end
