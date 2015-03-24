require 'rails_helper'

RSpec.describe Costumers::OmniauthCallbacksController, type: :controller do

  describe "GET #facebook" do
    it "returns http success" do
      get :facebook
      expect(response).to have_http_status(:success)
    end
  end

end
