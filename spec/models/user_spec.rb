require 'rails_helper'

RSpec.describe User, type: :model do 
  describe 'invalidations' do
    it "has a valid factory" do 
      FactoryGirl.create(:user).should be_valid
    end

    it "is invalid without a firstname" do 
      FactoryGirl.build(:user, first_name: nil).should_not be_valid
    end
    
    it "is invalid without a lastname"  do  
      FactoryGirl.build(:user, last_name: nil).should_not be_valid 
    end

    it "is invalid without an email" do 
      FactoryGirl.build(:user, email: nil).should_not be_valid 
    end

    it "is invalid without a password" do 
      FactoryGirl.build(:user, password: nil).should_not be_valid
    end
  end

  describe "associations" do 
    it { should have_many(:comments) }
    it { should have_many(:posts) }
  end
end
