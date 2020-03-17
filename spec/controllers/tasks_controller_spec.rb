require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  describe "#index" do
    
    # context "as an authenticate user" do
    #   before do 
    #     @user = FactoryBot.create(:user)
    #   end
    
      
    #   it "responds sucessfully" do
    #     sign_in @user
    #     get :index
    #     expect(response).to be_success
    #   end
      
    #   it "returns a 200 response" do
    #     sign_in @user
    #     get :index
    #     expect(response).to have_http_status "200"
    #   end
    # end
    
    context "as a guest" do
      it "responds unsucessfully" do
        get :index
        expect(response).to have_http_status "302"
      end
    end
  end
end
