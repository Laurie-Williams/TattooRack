require 'rails_helper'

RSpec.describe PiecesController, type: :controller do

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

  describe "Post #create" do

    context "Successfully Create Piece" do
      before :each do
        @piece = double("piece", save: true)
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
    end

    context "Fail to Create Piece" do
      before :each do
        @piece = double("piece", save: false)
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
end