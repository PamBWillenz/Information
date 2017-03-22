require 'rails_helper'

RSpec.describe PostsController, type: :controller do 
  
  describe "posts#destroy action" do 
    it "shouldn't allow users who did not create the post destroy it" do 
      p = FactoryGirl.create(:post)
      user = FactoryGirl.create(:user)
      sign_in user
      delete :destroy, id: p.id
      expect(response).to have_http_status(:forbidden)
    end

    it "shouldn't let unauthenticated users destroy a post" do 
      p = FactoryGirl.create(:post)
      delete :destroy, id: p.id
      expect(response).to redirect_to new_user_session_path
    end

    it "should allow a user to destroy a post" do 
      p = FactoryGirl.create(:post)
      sign_in p.user
      delete :destroy, id: p.id
      expect(response).to redirect_to root_path
      p = Post.find_by_id(p.id)
      expect(p).to eq nil
    end

    it "should return a 404 message if there is no post with that id" do 
      user = FactoryGirl.create(:user)
      sign_in user
      delete :destroy, id: 'SPOCK'
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "posts#update action" do 
    it "shouldn't let users who did not create the post update it" do 
      p = FactoryGirl.create(:post)
      user = FactoryGirl.create(:user)
      sign_in user
      patch :update, id: p.id, post: {title: 'Kirrrrk'}
      expect(response).to have_http_status(:forbidden)
    end

    it "shouldn't let unauthenticated users update a post" do 
      p = FactoryGirl.create(:post)
      patch :update, id: p.id, post: { title: "Hello"}
      expect(response).to redirect_to new_user_session_path
    end

    it "should allow users to successfully update posts" do 
      p = FactoryGirl.create(:post, title: "Initial Value")
      sign_in p.user
      patch :update, id: p.id, post: { title: 'Changed'}
      expect(response).to redirect_to root_path
      p.reload
      expect(p.title).to eq "Changed"
    end

    it "should have http 404 error if post cannot be found" do 
      user = FactoryGirl.create(:user)
      sign_in user

      patch :update, id: "CYCLE", post: { title: 'Changed'}
      expect(response).to have_http_status(:not_found)
    end

    it "should render the edit form with an http status of unprocessable_entity" do 
      p = FactoryGirl.create(:post, title: "Initial Value")
      sign_in p.user

      patch :update, id: p.id, post: { title: ''}
      expect(response).to have_http_status(:unprocessable_entity)
      p.reload
      expect(p.title).to eq "Initial Value"
    end
  end

  describe "posts#edit action" do 
    it "shouldn't let a user who did not create the post edit the post" do 
      p = FactoryGirl.create(:post)
      user = FactoryGirl.create(:user)
      sign_in user
      get :edit, id: p.id
      expect(response).to have_http_status(:forbidden)
    end

    it "shouldn't let unauthenticated users edit a post" do 
      p = FactoryGirl.create(:post)
      get :edit, id: p.id
      expect(response).to redirect_to new_user_session_path
    end

    it "should successfully show the edit form if the gram is found" do 
      p = FactoryGirl.create(:post)
      sign_in p.user

      get :edit, id: p.id
      expect(response).to have_http_status(:success)
    end

    it "should return a 404 error message if the post is not found" do 
      user = FactoryGirl.create(:user)
      sign_in user

      get :edit, id: 'TUGBOAT'
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "posts#show action" do 
    it "should successfully show the page if the post is found" do 
      p = FactoryGirl.create(:post)
      get :show, id: p.id
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
    it "should require users to logged in" do 
      get :new
      expect(response).to redirect_to new_user_session_path
    end

    it "should successfully show the new form" do 
      user = FactoryGirl.create(:user)
      sign_in user

      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "posts#create action" do 
    it "should require users to be logged in" do 
      post :create, post: { title: "Hello"}
      expect(response).to redirect_to new_user_session_path
    end

    it "should successfully create a new post in our database" do 
      user = FactoryGirl.create(:user)
      sign_in user

      post :create, post: {title: 'Hello!',
        message: 'Really'}
    
      expect(response).to redirect_to(post_path(assigns[:post]))

      post = Post.last
      expect(post.title).to eq("Hello!")
      expect(post.message).to eq("Really")
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
