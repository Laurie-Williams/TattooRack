require 'rails_helper'

RSpec.describe NotificationsController, type: :controller do
  describe "GET #index" do

    before :each do
      @user = double "User"
      allow(PublicActivity::Activity).to receive_message_chain(:all, :order, :where, :where, :not, :limit ).and_return(@tags)
      allow(subject).to receive(:current_user).and_return(@user)
    end

    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "assigns @activities variable" do
      get :index
      expect(assigns(:activities)).to eq(@activities)
    end

    it "returns notifications partial" do
      get :index
      expect(response).to render_template(partial: "notifications/_notifications")
    end

    it "redirects logged out user" do
      allow(subject).to receive(:current_user).and_return(nil)
      get :index
      expect(response).to redirect_to(new_user_session_path)
    end

  end

  describe "GET #count" do

    before :each do
      @user = double "User"
      allow(PublicActivity::Activity).to receive_message_chain(:where, :where, :not, :count ).and_return(1)
      allow(subject).to receive(:current_user ).and_return(@user)
    end

    it "returns http success" do
      get :count
      expect(response).to have_http_status(:success)
    end

    it "assigns @count variable" do
      get :count
      expect(assigns(:count)).to eq(1)
    end

    it "redirects logged out user" do
      allow(subject).to receive(:current_user).and_return(nil)
      get :count
      expect(response).to redirect_to(new_user_session_path)
    end

  end

  describe "POST #viewed" do

    before :each do
      @user = double "User"
      @activity = double "Activity", update_attributes: true, recipient: @user
      allow(PublicActivity::Activity).to receive(:find).with("1").and_return(@activity)
      allow(subject).to receive(:current_user ).and_return(@user)
    end

    it "finds activity" do
      post :viewed, id: 1
      expect(assigns(:activity)).to eq(@activity)
    end

    it "sets activity to viewed" do
      expect(@activity).to receive(:update_attributes).with(viewed: true).and_return(true)
      post :viewed, id: 1
    end

    it "redirects logged out user" do
      allow(subject).to receive(:current_user).and_return(nil)
      post :viewed, id: 1
      expect(response).to redirect_to(new_user_session_path)
    end

    it "redirects user who is not analytics recipient" do
      allow(@activity).to receive(:recipient).and_return("not recipient")
      post :viewed, id: 1
      expect(response).to redirect_to(root_path)
    end

  end
end
