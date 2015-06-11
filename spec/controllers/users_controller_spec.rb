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

  describe "POST #update" do

    context "successfully update bio attribute" do

      before :each do
        @user = double("user", update_attributes: true, id: "1")
      end

      it "returns http success" do
        allow(User).to receive(:find).with("1").and_return(@user)
        post :update, id: 1, user: {bio: "I am an artist"}
        expect(response).to have_http_status(:redirect)
      end

      it "calls .find on User" do
        expect(User).to receive(:find).with("1").and_return(@user)
        post :update, id: 1, user: {bio: "I am an artist"}
      end

      it "assigns @user variable" do
        allow(User).to receive(:find).with("1").and_return(@user)
        post :update, id: 1, user: {bio: "I am an artist"}
        expect(assigns(:user)).to eq(@user)
      end


      it "calls update attributes on @user" do
        expect(@user).to receive(:update_attributes).and_return(true)
        allow(User).to receive(:find).with("1").and_return(@user)
        post :update, id: 1, user: {bio: "I am an artist"}
      end

      it "assigns a notice flash" do
        allow(User).to receive(:find).with("1").and_return(@user)
        post :update, id: 1, user: {bio: "I am an artist"}
        expect(flash[:notice]).to eq("You have updated your settings")
      end

    end

    context "unsuccessful update" do

      before :each do
        @user = double("user", update_attributes: false, id: 1)
      end

      it "returns http success" do
        allow(User).to receive(:find).with("1").and_return(@user)
        post :update, id: 1, user: {bio: "I am an artist"}
        expect(response).to have_http_status(:success)
      end

      it "renders Update Settings page" do
        allow(User).to receive(:find).with("1").and_return(@user)
        post :update, id: 1, user: {bio: "I am an artist"}
        expect(subject).to render_template(:edit)
      end
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      user = double("user")
      allow(User).to receive(:find).with("1").and_return(user)
      get :edit, id: 1
      expect(response).to have_http_status(:success)
    end

    it "calls .find on User" do
      user = double("user")
      expect(User).to receive(:find).with("1").and_return(user)
      get :edit, id: 1
    end

    it "assigns @user variable" do
      user = double("user")
      allow(User).to receive(:find).with("1").and_return(user)
      get :edit, id: 1
      expect(assigns(:user)).to eq(user)
    end

  end

end
