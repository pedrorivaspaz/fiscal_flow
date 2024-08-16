require 'rails_helper'

RSpec.describe "Recipients", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/recipients/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/recipients/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/recipients/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/recipients/edit"
      expect(response).to have_http_status(:success)
    end
  end

end
