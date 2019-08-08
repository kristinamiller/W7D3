require 'rails_helper'

feature "Sign Up" do

  before :each do
    visit new_user_url
  end

  scenario 'has a user sign up page' do
    # visit new_user_url

    expect(page).to have_content("Create Account")
  end

  scenario 'has username and password inputs' do
    expect(page).to have_content("username")
    expect(page).to have_content("password")
  end

  scenario "redirects to user's show page on success" do
    fill_in "username", with: "vanessa"
    fill_in "password", with: "idunno"

    click_button "create account"

    user = User.find_by(username: "vanessa")

    expect(page).to have_content("vanessa")
    expect(current_url).to eq(user_url(user))
  end
  
end

