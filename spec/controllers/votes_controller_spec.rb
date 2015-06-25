require 'rails_helper'

RSpec.describe VotesController, type: :controller do

  describe "POST #like" do
    before :each do
      request.env["HTTP_REFERER"] = piece_url(1)
      @user = FactoryGirl.build_stubbed(:user)
      @piece = FactoryGirl.build_stubbed(:piece)
      allow(subject).to receive(:current_user).and_return(@user)
      allow(@piece).to receive(:liked_by).and_return(true)
      allow(Piece).to receive(:find).and_return(@piece)
    end

    context "Successfully Create Piece" do
      before :each do
      end

      it "returns http redirect" do
        post :like, piece_id: 1
        expect(response).to redirect_to(:back)
      end

      it "returns like count for AJAX request" do
        xhr :post, :like, piece_id: 1
        expect(response).to render_template(partial: "_likes")
      end

    end

    context "Fail to Create Piece" do
      before :each do
      end

      it "returns http redirect" do
        post :like, piece_id: 1
        expect(response).to redirect_to(:back)
      end

      it "returns like count for AJAX request" do
        xhr :post, :like, piece_id: 1
        expect(response).to render_template(partial: "_likes")
      end


    end

    it "redirects Signed Out users" do
      allow(subject).to receive(:current_user).and_return(nil)
      post :like, piece_id: 1
      expect(response).to redirect_to(new_user_session_path)
    end

  end

  describe "DELETE #unlike" do
    before :each do
      request.env["HTTP_REFERER"] = piece_url(1)
      @user = FactoryGirl.build_stubbed(:user)
      @piece = FactoryGirl.build_stubbed(:piece)
      allow(subject).to receive(:current_user).and_return(@user)
      allow(@piece).to receive(:liked_by).and_return(true)
      allow(Piece).to receive(:find).and_return(@piece)
    end

    context "Successfully Create Piece" do
      before :each do
      end

      it "returns http redirect" do
        delete :unlike, piece_id: 1
        expect(response).to redirect_to(:back)
      end

      it "returns like count for AJAX request" do
        xhr :delete, :unlike, piece_id: 1
        expect(response).to render_template(partial: "_likes")
      end

    end

    context "Fail to Create Piece" do
      before :each do
      end

      it "returns http redirect" do
        delete :unlike, piece_id: 1
        expect(response).to redirect_to(:back)
      end

      it "returns like count for AJAX request" do
        xhr :delete, :unlike, piece_id: 1
        expect(response).to render_template(partial: "_likes")
      end


    end

    it "redirects Signed Out users" do
      allow(subject).to receive(:current_user).and_return(nil)
      delete :unlike, piece_id: 1
      expect(response).to redirect_to(new_user_session_path)
    end

  end


end
