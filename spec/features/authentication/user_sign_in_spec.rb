require 'rails_helper'

RSpec.feature "New user session" do
  let!(:user) { create :user }

  scenario "with valid credentials" do
    visit "/"
    click_link "Log In"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign in"
    expect(page).to have_content("Signed in successfully.")
  end

  scenario "with invalid credentials" do
    visit "/"
    click_link "Log In"
    fill_in "Email", with: user.email
    fill_in "Password", with: " "
    click_button "Sign in"
    expect(page).to have_content("Invalid Email or password.")
  end
end