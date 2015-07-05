require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "GET #index" do
    before :each do
      @users = double("users")
      allow(User).to receive_message_chain(:all, :page, :per).and_return(@users)
    end

    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "calls .all on User" do
      expect(User).to receive(:all).and_return(@users)
      allow(@users).to receive_message_chain(:page, :per)
      get :index
    end

    it "assigns @users variable" do
      get :index
      expect(assigns(:users)).to eq(@users)
    end

  end

  describe "PUT #update" do

    context "successfully update bio attribute" do

      before :each do
        @user = double("user", update_attributes: true, id: "1", admin?: false)
        allow(controller).to receive(:current_user).and_return(@user)
        allow(User).to receive(:find).with("1").and_return(@user)

      end

      it "returns http success correct user" do
        post :update, id: 1, user: {bio: "I am an artist"}
        expect(response).to have_http_status(:redirect)
      end

      it "returns http success for admin user" do
        @user2 = double("user", update_attributes: true, admin?: true)
        allow(User).to receive(:find).with("1").and_return(@user2)

        post :update, id: 1, user: {bio: "I am an artist"}
        expect(response).to have_http_status(:redirect)
      end


      it "calls .find on User" do
        expect(User).to receive(:find).with("1").and_return(@user)
        post :update, id: 1, user: {bio: "I am an artist"}
      end

      it "assigns @user variable" do
        post :update, id: 1, user: {bio: "I am an artist"}
        expect(assigns(:user)).to eq(@user)
      end

      it "calls update attributes on @user" do
        expect(@user).to receive(:update_attributes).and_return(true)
        post :update, id: 1, user: {bio: "I am an artist"}
      end

      it "assigns a notice flash" do
        post :update, id: 1, user: {bio: "I am an artist"}
        expect(flash[:notice]).to eq("You have updated your settings")
      end

    end

    context "unsuccessful update" do

      before :each do
        @user = double("user", admin?: false, update_attributes: false, id: 1)
        allow(controller).to receive(:current_user).and_return(@user)
        allow(User).to receive(:find).with("1").and_return(@user)
      end

      it "returns http success" do
        post :update, id: 1, user: {bio: "I am an artist"}
        expect(response).to have_http_status(:success)
      end

      it "renders Update Settings page" do
        post :update, id: 1, user: {bio: "I am an artist"}
        expect(subject).to render_template(:edit)
      end

      it "redirects Unauthorized users" do
        @user2 = double("user", admin?: false)
        allow(subject).to receive(:current_user).and_return(@user2)

        put :update, id: "1"
        expect(response).to have_http_status(:redirect)
      end
    end

    it "redirects Signed Out users" do
      allow(subject).to receive(:current_user).and_return(nil)
      put :update, id: "1"
      expect(response).to have_http_status(:redirect)
    end
  end

  describe "GET #edit" do

    before :each do
      @user = double("user", admin?: false)
      allow(controller).to receive(:current_user).and_return(@user)
      allow(User).to receive(:find).with("1").and_return(@user)
    end

    it "returns http success" do
      get :edit, id: 1
      expect(response).to have_http_status(:success)
    end

    it "returns http success for admin user" do
      @user2 = double("user", admin?: true)
      allow(controller).to receive(:current_user).and_return(@user)

      get :edit, id: 1
      expect(response).to have_http_status(:success)
    end

    it "calls .find on User" do
      expect(User).to receive(:find).with("1").and_return(@user)
      get :edit, id: 1
    end

    it "assigns @user variable" do
      get :edit, id: 1
      expect(assigns(:user)).to eq(@user)
    end

    it "redirects Unauthorized users" do
      @user2 = double("user", admin?: false)
      allow(subject).to receive(:current_user).and_return(@user2)

      put :edit, id: "1"
      expect(response).to have_http_status(:redirect)
    end

    it "redirects Signed Out users" do
      allow(subject).to receive(:current_user).and_return(nil)
      get :edit, id: "1"
      expect(response).to have_http_status(:redirect)
    end

  end

  describe "GET #show" do
    before :each do
      @user = double("user")
      allow(User).to receive(:find).with("1").and_return(@user)
      get :show, id: "1"
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "calls .all on User" do
      expect(User).to receive(:find).with("1").and_return(@user)
      get :show, id: "1"
    end

    it "assigns @users variable" do
      expect(assigns(:user)).to eq(@user)
    end



  end

  describe "DELETE #destroy" do

    context "current_user is admin" do

      before :each do
        @user = double("user", admin?: false, destroy: true)
        @user2 = double("user", admin?: true)

        allow(subject).to receive(:current_user).and_return(@user2)
        allow(User).to receive(:find).with("1").and_return(@user)
      end

      it "finds the piece" do
        expect(User).to receive(:find).with("1").and_return(@user)
        delete :destroy, id: "1"
      end

      it "assigns an instance variable" do
        delete :destroy, id: "1"
        expect(assigns(:user)).to eq(@user)
      end

      it "destroys the piece" do
        expect(@user).to receive(:destroy).and_return(true)
        delete :destroy, id: "1"
      end

      it "renders a redirect and flash" do
        delete :destroy, id: "1"
        expect(response).to have_http_status(:redirect)
        expect(flash[:notice]).to eq("The user was deleted")
      end

    end

    context "Piece is not destroyed" do

      before :each do
        @user = double("user", admin?: false, destroy: true)
        @user2 = double("user", admin?: false)

        allow(subject).to receive(:current_user).and_return(@user2)
        allow(User).to receive(:find).with("1").and_return(@user)
      end

      it "finds the piece" do
        expect(User).to receive(:find).with("1").and_return(@user)
        delete :destroy, id: "1"
      end

      it "assigns an instance variable" do
        delete :destroy, id: "1"
        expect(assigns(:user)).to eq(@user)
      end

      it "renders a flash" do
        delete :destroy, id: "1"
        expect(flash[:alert]).to eq("You do not have permission to view this page")
      end

    end

    it "redirects Signed Out users" do
      allow(subject).to receive(:current_user).and_return(nil)
      delete :destroy, id: "1"
      expect(response).to have_http_status(:redirect)
    end
  end
end
