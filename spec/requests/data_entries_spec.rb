require 'rails_helper'

RSpec.describe "DataEntries", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/data_entries/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/data_entries/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/data_entries/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/data_entries/edit"
      expect(response).to have_http_status(:success)
    end
  end

end
