require 'rails_helper'

RSpec.describe SearchController, type: :controller do

  describe "GET #search" do

    it "redirects to root if no query" do
      get :search
      expect(response).to redirect_to(root_path)
    end

    it "renders search view if query exists" do
      get :search, q: "query"
      expect(response).to render_template(:search)
    end

  end

end
