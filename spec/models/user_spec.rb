require 'rails_helper'

RSpec.describe User, type: :model do 
  # describe 'creation' do 
  #   before do 
  #     user = User.create(email: "kitty@meow.com", password: "password", password_confirmation: "password", 
  #       first_name: "Pixel", last_name: "Kitty")
  #   end

  #   it 'should be able to be created if valid' do 
  #     expect(user.to be_valid)
  #   end
  # end

  # describe 'validations' do 
  #   it 'should not be valid without a first name' do 
  #     user.first_name = nil
  #     expect(user).to_not be_valid
  #   end

  #   it 'should not be valid without a last name' do 
  #     user.last_name = nil
  #     expect(user).to_not be_valid
  #   end
  # end
end
