require 'rails_helper'

RSpec.describe PostsController, type: :controller do 
  
  describe "posts#destroy action" do 
    it "should allow a user to destroy a post" do 
      post = FactoryGirl.create(:post)
      delete :destroy, id: post.id
      expect(response).to redirect_to root_path
      post = Post.find_by_id(post.id)
      expect(post).to eq nil
    end

    it "should return a 404 message if there is no post with that id" do 
      delete :destroy, id: 'SPOCK'
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "posts#update action" do 
    it "should allow users to successfully update posts" do 
      post = FactoryGirl.create(:post, title: "Initial Value")
      patch :update, id: post.id, post: { title: 'Changed'}
      expect(response).to redirect_to root_path
      post.reload
      expect(post.title).to eq "Changed"
    end

    it "should have http 404 error if post cannot be found" do 
      patch :update, id: "CYCLE", post: { title: 'Changed'}
      expect(response).to have_http_status(:not_found)
    end

    it "should render the edit form with an http status of unprocessable_entity" do 
      post = FactoryGirl.create(:post, title: "Initial Value")
      patch :update, id: post.id, post: { title: ''}
      expect(response).to have_http_status(:unprocessable_entity)
      post.reload
      expect(post.title).to eq "Initial Value"
    end
  end

  describe "posts#edit action" do 
    it "should successfully show the edit form if the gram is found" do 
      post = FactoryGirl.create(:post)
      get :edit, id: post.id
      expect(response).to have_http_status(:success)
    end

    it "should return a 404 error message if the post is not found" do 
      get :edit, id: 'TUGBOAT'
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "posts#show action" do 
    it "should successfully show the page if the post is found" do 
      post = FactoryGirl.create(:post)
      get :show, id: post.id
      expect(response).to have_http_status(:success)
    end

    it "should return a 404 error if the post is not found" do 
      get :show, id: 'KITTYCAT'
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "posts#index action" do 
    it "should successfully show the page" do 
      get :index
      expect(response).to have_http_status(:success) 
    end
  end

  describe "posts#new action" do 
    it "should successfully show the new form" do 
      user = FactoryGirl.create(:user)
      
      sign_in user

      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "posts#create action" do 
    it "should successfully create a new post in our database" do 
      user = FactoryGirl.create(:user)
      
      sign_in user

      post :create, post: {title: 'Hello!'}
      expect(response).to redirect_to root_path

      post = Post.last
      expect(post.title).to eq("Hello!")
      expect(post.user).to eq(user)
    end

    it "should handle validation errors" do 
      user = FactoryGirl.create(:user)
      
      sign_in user
      
      post_count = Post.count
      post :create, post: {title: ''}
      expect(response).to have_http_status(:unprocessable_entity)
      expect(post_count).to eq Post.count
    end
  end
end
