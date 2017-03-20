require 'rails_helper'

feature "signing in" do
  let(:user) {FactoryGirl.create(:user)}
  
  def fill_in_signin_fields
    fill_in "user[first_name]", with: user.first_name
    fill_in "user[last_name]", with: user.last_name
    fill_in "user[email]", with: user.email
    fill_in "user[password]", with: user.password
    click_button "Sign in"
  end

  scenario "visiting the site to sign in" do
    visit root_path
    click_link "Sign In"
    fill_in_signin_fields
    expect(page).to have_content("Signed in successfully.")
  end

  scenario "signing out" do
    visit root_path
    click_link "Sign In"
    fill_in_signin_fields
    click_link "Sign out"
    expect(page).to have_content("Signed out successfully.")
  end
end
