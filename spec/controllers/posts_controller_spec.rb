require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  describe "posts#index action" do 
    it "should successfully show the page" do 
      get :index
      expect(response).to have_http_status(:success) 
    end
  end

  describe "posts#new action" do 
    it "should successfully show the new form" do 
      user = User.create(
        email:                  'fakeuser@gmail.com',
        password:               'secretPassword',
        password_confirmation:  'secretPassword'
      )
      sign_in user

      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "posts#create action" do 
    it "should successfully create a new post in our database" do 
      user = User.create(
        email:                  'fakeuser@gmail.com',
        password:               'secretPassword',
        password_confirmation:  'secretPassword'
      )
      sign_in user

      post :create, post: {title: 'Hello!'}
      expect(response).to redirect_to root_path

      post = Post.last
      expect(post.title).to eq("Hello!")
      expect(post.user).to eq(user)
    end

    it "should handle validation errors" do 
      user = User.create(
        email:                  'fakeuser@gmail.com',
        password:               'secretPassword',
        password_confirmation:  'secretPassword'
      )
      sign_in user

      post_count = Post.count
      post :create, post: {title: ''}
      expect(response).to have_http_status(:unprocessable_entity)
      expect(post.count).to eq Post.count
    end
  end
end
