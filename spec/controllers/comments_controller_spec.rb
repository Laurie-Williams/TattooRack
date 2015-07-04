require 'rails_helper'

RSpec.describe CommentsController, type: :controller do


  describe "POST #create" do
    before :each do
      @comment = double "Comment"
      @comments = double("Comments", create: @comment)
      @piece = FactoryGirl.build_stubbed(:piece)
      @user = double "User"
      allow(@piece).to receive(:comments).and_return(@comments)
      allow(Comment).to receive(:find_commentable).and_return(@piece)
      allow(subject).to receive(:current_user).and_return(@user)
      request.env["HTTP_REFERER"] = piece_url(@piece)
    end

    context "Successfully Created" do
      it "redirects to commentable page" do
        post :create, piece_id: @piece, comment: {comment: "Test Comment", user_id: 1}
        expect(response).to redirect_to(:back)
      end

      it "assigns notice flash" do
        post :create, piece_id: @piece, comment: {comment: "Test Comment"}
        expect(flash[:notice]).to be_present
      end
    end

    context "Not created" do
      before :each do
        allow(@comments).to receive(:create).and_return(false)
      end

      it "redirects to commentable page" do
        post :create, piece_id: @piece, comment: {comment: "Test Comment"}
        expect(response).to redirect_to(piece_path(@piece))
      end

      it "assigns alert flash" do
        post :create, piece_id: @piece, comment: {comment: "Test Comment"}
        expect(flash[:alert]).to be_present
      end
    end

    it "Redirects logged out user to log in page" do
      allow(subject).to receive(:current_user).and_return(nil)
      post :create, piece_id: @piece, comment: {comment: "Test Comment"}
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "POST #destroy" do

    before :each do
      @user = double "User"
      @comment = double "Comment", destroy: true, user: @user
      @piece = FactoryGirl.build_stubbed(:piece)
      allow(subject).to receive(:current_user).and_return(@user)
      allow(Comment).to receive(:find_commentable).and_return(@piece)
      allow(Comment).to receive(:find).and_return(@comment)
      request.env["HTTP_REFERER"] = piece_url(@piece)
    end

    context "Successfully destroyed" do
      it "returns http success" do
        post :destroy, piece_id: @piece, id: 1
        expect(response).to redirect_to(:back)
      end

      it "assigns notice flash" do
        post :destroy, piece_id: @piece, id: 1
        expect(flash[:notice]).to be_present
      end
    end

    context "Not destroyed" do
      before :each do
        allow(@comment).to receive(:destroy).and_return(false)
      end

      it "returns http success" do
        post :destroy, piece_id: @piece, id: 1
        expect(response).to redirect_to(:back)
      end

      it "assigns notice flash" do
        post :destroy, piece_id: @piece, id: 1
        expect(flash[:alert]).to be_present
      end
    end

    it "Redirects logged out user to log in page" do
      allow(subject).to receive(:current_user).and_return(nil)
      post :destroy, piece_id: @piece, id: 1
      expect(response).to redirect_to(new_user_session_path)
    end

    it "Redirects user who did not create comment" do
      allow(subject).to receive(:current_user).and_return("not user")
      post :destroy, piece_id: @piece, id: 1
      expect(response).to redirect_to(root_path)
    end
  end

end
