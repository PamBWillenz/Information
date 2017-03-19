require 'rails_helper'

RSpec.describe CommentsController, type: :controller do 
  
  describe "comments#create action" do 
    it "should allow users to create comments on posts" do 
      p = FactoryGirl.create(:post)
      user = FactoryGirl.create(:user)
      sign_in user

      post :create, post_id: p.id, comment: { message: 'awesome post'}

      expect(response).to redirect_to root_path
      expect(p.comments.length).to eq 1
      expect(p.comments.first.message).to eq "awesome post"
    end

    it "should require a user to be logged in to comment on a post" do 
      p = FactoryGirl.create(:post)
      post :create, post_id: p.id, comment: { message: 'awesome post'}
      expect(response).to redirect_to new_user_session_path
    end

    it "should return http status code if the post isn't found" do 
      user = FactoryGirl.create(:user)
      sign_in user
      post :create, post_id: 'SPOCK', comment: { message: 'awesome post'}
      expect(response).to have_http_status :not_found
    end
  end
end
