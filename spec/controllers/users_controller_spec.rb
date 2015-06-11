require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "calls .all on User" do
      users = double("users")
      expect(User).to receive(:all).and_return(users)
      get :index
    end

    it "assigns @users variable" do
      users = double("users")
      allow(User).to receive(:all).and_return(users)
      get :index
      expect(assigns(:users)).to eq(users)
    end

  end

end
