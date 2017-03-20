require 'rails_helper'

RSpec.describe User, type: :model do 
  describe 'validations' do
    it "has a valid factory" do
      expect(FactoryGirl.create(:user)).to be_valid
    end

    it "is valid with valid attributes" do
      user.first_name = "Jon"
      user.last_name = "Snow"
      user.email = "jon@castleblack.com"
      user.password = "whitewalker"
      expect(user).to be_valid
    end

    it "is not valid without a first_name" do 
      expect(user).to_not be_valid
    end

    it "is not valid without a last_name" do
      expect(user).to_not be_valid
    end
  end
end
