require 'rails_helper'

feature "user registers for site" do

  scenario "user registers" do
    visit root_path
    click_link "Sign Up"
    fill_in_registration_fields
    expect(page).to have_content("Welcome! You have signed up successfully.")
end

def fill_in_registration_fields
    fill_in "user[first_name]", with: "Jamie"
    fill_in "user[last_name]", with: "Lannister"
    fill_in "user[email]", with: "jamie@kingslanding.com"
    fill_in "user[password]", with: "dragon"
    fill_in "user[password_confirmation]", with: "dragon"
    click_button "Sign up"
  end
end
