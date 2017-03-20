require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'invalidations' do
    it "has a valid factory" do 
      FactoryGirl.create(:post).should be_valid
    end

    it "is invalid without a title" do 
      FactoryGirl.build(:post, title: nil).should_not be_valid
    end
    
    it "is invalid without a message"  do  
      FactoryGirl.build(:post, message: nil).should_not be_valid 
    end
  end
end


