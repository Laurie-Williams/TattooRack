require 'rails_helper'

RSpec.describe NotificationsController, type: :controller do
  describe "GET #index" do

    before :each do
      @user = double "User"
      allow(PublicActivity::Activity).to receive_message_chain(:all, :order, :where, :where, :not ).and_return(@tags)
      allow(subject).to receive(:current_user ).and_return(@user)
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


  end

  describe "POST #viewed" do

    before :each do
      @activity = double "Activity", update_attributes: true
      allow(PublicActivity::Activity).to receive(:find).with("1").and_return(@activity)
    end

    it "finds activity" do
      post :viewed, id: 1
      expect(assigns(:activity)).to eq(@activity)
    end

    it "sets activity to viewed" do
      expect(@activity).to receive(:update_attributes).with(viewed: true).and_return(true)
      post :viewed, id: 1
    end
  end
end
