require 'rails_helper'

RSpec.describe User, type: :model do 
  # describe 'creation' do 
  #   before do 
  #     current_user = User.create(email: "kitty@meow.com", password: "password", password_confirmation: "password", 
  #       first_name: "Pixel", last_name: "Kitty")
  #   end

  #   it 'should be able to be created if valid' do 
  #     expect(current_user.to be_valid)
  #   end
  # end

  # describe 'validations' do 
  #   it 'should not be valid without a first name' do 
  #     current_user.first_name = nil
  #     expect(current_user).to_not be_valid
  #   end

  #   it 'should not be valid without a last name' do 
  #     current_user.last_name = nil
  #     expect(current_user).to_not be_valid
  #   end
  # end
end
