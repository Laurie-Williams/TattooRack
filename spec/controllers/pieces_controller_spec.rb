require 'rails_helper'

RSpec.describe PiecesController, type: :controller do

  describe "GET #show" do

    context "Piece is published" do

      before :each do
        @piece = double("piece", published?: true)
        allow(Piece).to receive(:find).with("1").and_return(@piece)
      end

      it "returns http success" do
        get :show, id: "1"
        expect(response).to have_http_status(:success)
      end

      it "calls .find on Piece" do
        expect(Piece).to receive(:find).with("1").and_return(@piece)
        get :show, id: "1"
      end

      it "checks if published" do
        expect(@piece).to receive(:published?).and_return(true)
        get :show, id: "1"
      end

      it "assigns @users variable" do
        get :show, id: "1"
        expect(assigns(:piece)).to eq(@piece)
      end
    end

    context "Piece is not published" do
      before :each do
        @piece = double("user", published?: false)
        allow(Piece).to receive(:find).with("1").and_return(@piece)
      end

      it "returns http redirect" do
        get :show, id: "1"
        expect(response).to have_http_status(:redirect)
        expect(flash[:alert]).to eq("Piece could not be found")
      end

      it "checks if published" do
        expect(@piece).to receive(:published?).and_return(false)
        get :show, id: "1"
      end

      it "calls .all on Piece" do
        expect(Piece).to receive(:find).with("1").and_return(@piece)
        get :show, id: "1"
      end

      it "assigns @users variable" do
        get :show, id: "1"
        expect(assigns(:piece)).to eq(@piece)
      end
    end

  end

  describe "GET #new" do
    before :each do
      @piece = double("piece")
      allow(Piece).to receive(:new).and_return(@piece)
    end

    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "calls .new on Piece" do
      expect(Piece).to receive(:new).and_return(@piece)
      get :new
    end

    it "assigns @pieces variable" do
      get :new
      expect(assigns(:piece)).to eq(@piece)
    end
  end

  describe "POST #create" do

    context "Successfully Create Piece" do
      before :each do
        @piece = double("piece", save: true, check_and_set_title: nil)
        allow(Piece).to receive(:new).and_return(@piece)
      end

      it "returns http redirect" do
        post :create, piece: {image: "Test Image"}
        expect(response).to have_http_status :redirect
      end

      it "calls .new on Piece" do
        expect(Piece).to receive(:new).and_return(@piece)
        post :create, piece: {image: "Test Image"}
      end


      it "calls .save on @piece" do
        expect(@piece).to receive(:save).and_return(true)
        post :create, piece: {image: "Test Image"}
      end

      it "assigns @piece correctly" do
        post :create, piece: {image: "Test Image"}
        expect(assigns(:piece)).to eq(@piece)
      end

      it "returns correct .json response" do
        @piece = double("piece", save: true, check_and_set_title: nil)
        post :create, piece: {image: "Test Image"}, format: :json
        expect(response.body).to eq(@piece.to_json)
      end
    end

    context "Fail to Create Piece" do
      before :each do
        @piece = double("piece", save: false, check_and_set_title: nil)
        allow(Piece).to receive(:new).and_return(@piece)
      end

      it "returns http redirect" do
        post :create, piece: {image: "Test Image"}
        expect(response).to render_template :new
      end

      it "calls .new on Piece" do
        expect(Piece).to receive(:new).and_return(@piece)
        post :create, piece: {image: "Test Image"}
      end

      it "calls .save on @piece" do
        expect(@piece).to receive(:save).and_return(false)
        post :create, piece: {image: "Test Image"}
      end

    end

  end

  describe "POST #update" do

    context "successfully update bio attribute" do

      before :each do
        @piece = double("piece", update_attributes: true, id: "1")
        allow(Piece).to receive(:find).with("1").and_return(@piece)

      end

      it "returns http success" do
        post :update, id: 1, piece: {title: "My Piece Title"}
        expect(response).to have_http_status(:redirect)
      end

      it "calls .find on User" do
        expect(Piece).to receive(:find).with("1").and_return(@piece)
        post :update, id: 1, piece: {title: "My Piece Title"}
      end

      it "assigns @user variable" do
        post :update, id: 1, piece: {title: "My Piece Title"}
        expect(assigns(:piece)).to eq(@piece)
      end


      it "calls update attributes on @user" do
        expect(@piece).to receive(:update_attributes).and_return(true)
        post :update, id: 1, piece: {title: "My Piece Title"}
      end

      it "assigns a notice flash" do
        post :update, id: 1, piece: {title: "My Piece Title"}
        expect(flash[:notice]).to eq("Your piece has been updated")
      end

    end

    context "unsuccessful update" do

      before :each do
        @piece = double("piece", update_attributes: false, id: 1)
        allow(Piece).to receive(:find).with("1").and_return(@piece)
      end

      it "returns http success" do
        post :update, id: 1, piece: {title: "My Piece Title"}
        expect(response).to have_http_status(:success)
      end

      it "renders Update Settings page" do
        post :update, id: 1, piece: {title: "My Piece Title"}
        expect(subject).to render_template(:edit)
      end
    end
  end

  describe "DELETE #destroy" do

    context "Piece is successfully destroyed" do

      before :each do
        @piece = double("piece", destroy: true)
        allow(Piece).to receive(:find).with("1").and_return(@piece)
      end

      it "finds the piece" do
        expect(Piece).to receive(:find).with("1").and_return(@piece)
        delete :destroy, id: "1"
      end

      it "assigns an instance variable" do
        delete :destroy, id: "1"
        expect(assigns(:piece)).to eq(@piece)
      end

      it "destroys the piece" do
        expect(@piece).to receive(:destroy).and_return(true)
        delete :destroy, id: "1"
      end

      it "renders a redirect and flash" do
        delete :destroy, id: "1"
        expect(response).to have_http_status(:redirect)
        expect(flash[:notice]).to eq("Your piece has been deleted")
      end
    end

    context "Piece is not destroyed" do

      before :each do
        @piece = double("piece", destroy: false)
        allow(Piece).to receive(:find).with("1").and_return(@piece)
      end

      it "finds the piece" do
        expect(Piece).to receive(:find).with("1").and_return(@piece)
        delete :destroy, id: "1"
      end

      it "assigns an instance variable" do
        delete :destroy, id: "1"
        expect(assigns(:piece)).to eq(@piece)
      end

      it "renders a flash" do
        delete :destroy, id: "1"
        expect(flash[:alert]).to eq("Your piece was not deleted")
      end
    end
  end

end