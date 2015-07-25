require 'rails_helper'

RSpec.describe TagsController, type: :controller do

  describe "GET #index" do

    before :each do
      @tags = ["Tag1", "Tag2"]
      allow(ActsAsTaggableOn::Tag).to receive_message_chain(:all, :pluck).and_return(@tags)
    end

    it "returns http success" do
      xhr :get, :index
      expect(response).to have_http_status(:success)
    end

    it "assigns @tags variable" do
      xhr :get, :index
      expect(assigns(:tags)).to eq(@tags)
    end

    it "returns tags as json" do
      xhr :get, :index
      expect(response.body).to eq(@tags.to_json)
    end

  end

  describe "GET #show" do


    before :each do
      @pieces = double "Pieces"
      allow(Piece).to receive_message_chain(:published, :tagged_with, :page, :per).and_return(@pieces)
    end

    it "returns http success" do
      get :show, tag: "tag"
      expect(response).to render_template("tags/show")
    end

    it "assigns @pieces variable" do
      get :show, tag: "tag"
      expect(assigns(:pieces)).to eq(@pieces)
    end


  end

  describe "POST #create" do

    context "User Logged in" do
      before :each do
        @user = double("user", pieces: @pieces)
        @tag_list = double("Tag List", add: ["tag1"])
        @piece = double("Piece", tag_list: @tag_list, save: true, user: @user)
        allow(subject).to receive(:current_user).and_return(@user)
        allow(Piece).to receive(:find).with("1").and_return(@piece)
      end

      it "finds taggable object" do
        expect(Piece).to receive(:find).with("1").and_return(@piece)
        post :create, tag: "tag", piece_id: 1
        request.path = "pieces/1/tags"
      end

      it "adds a tag" do
        expect(@tag_list).to receive(:add).with("tag")
        post :create, tag: "tag", piece_id: 1
        request.path = "pieces/1/tags"
      end

      it "updates taggable object" do
        expect(@piece).to receive(:save)
        post :create, tag: "tag", piece_id: 1
        request.path = "pieces/1/tags"
      end

      it "renders the deleted_tag_list partial" do
        expect(response).to render_template(partial: "delete_tag_list", locals: { piece: @piece })
        post :create, tag: "tag", piece_id: 1
        request.path = "pieces/1/tags"
      end

      it "redirects if current user is not taggable owner" do
        allow(subject).to receive(:current_user).and_return("Not Owner")
        post :create, tag: "tag", piece_id: 1
        expect(response).to redirect_to(root_path)
      end
    end

    it "redirects logged out user" do
      allow(subject).to receive(:current_user).and_return(nil)
      post :create, tag: "tag", piece_id: 1
      expect(response).to redirect_to(new_user_session_path)
    end

  end

  describe "DELETE #destroy" do

    context "User Logged in" do
      before :each do
        @user = double("user", pieces: @pieces)
        @tag_list = double("Tag List", remove: [])
        @piece = double("Piece", tag_list: @tag_list, save: true, user: @user)
        allow(subject).to receive(:current_user).and_return(@user)
        allow(Piece).to receive(:find).with("1").and_return(@piece)
      end

      it "finds taggable object" do
        expect(Piece).to receive(:find).with("1").and_return(@piece)
        delete :destroy, piece_id: 1, id: "tag"
        request.path = "pieces/1/tags/tag"
      end

      it "removes a tag" do
        expect(@tag_list).to receive(:remove).with("tag")
        delete :destroy, piece_id: 1, id: "tag"
        request.path = "pieces/1/tags/tag"
      end

      it "updates taggable object" do
        expect(@piece).to receive(:save)
        delete :destroy, piece_id: 1, id: "tag"
        request.path = "pieces/1/tags/tag"
      end

      it "renders the deleted_tag_list partial" do
        expect(response).to render_template(partial: "delete_tag_list", locals: { piece: @piece })
        delete :destroy, piece_id: 1, id: "tag"
        request.path = "pieces/1/tags/tag"
      end

      it "redirects if current user is not taggable owner" do
        allow(subject).to receive(:current_user).and_return("Not Owner")
        delete :destroy, piece_id: 1, id: "tag"
        expect(response).to redirect_to(root_path)
      end
    end

    it "redirects logged out user" do
      allow(subject).to receive(:current_user).and_return(nil)
      delete :destroy, piece_id: 1, id: "tag"
      expect(response).to redirect_to(new_user_session_path)
    end

  end

end
