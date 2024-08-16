require 'rails_helper'

RSpec.describe "Issuers", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/issuers/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/issuers/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/issuers/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/issuers/edit"
      expect(response).to have_http_status(:success)
    end
  end

end
