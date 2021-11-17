require 'rails_helper'

RSpec.feature "UserLogins", type: :feature,  js: true do
  
  before :each do 
    password = "supersecret"
    @user = User.create!(
      first_name: "99999",
      last_name: "99998",
      email: "9999@gmail.com",
      password: '999990',
      password_confirmation: "999990")
  end 

  scenario "they can login successful after signup" do 
    visit login_path
    fill_in 'email', with: @user.email
    fill_in 'password', with: @user.password
    click_button "Submit"

    save_screenshot
    expect(page).to have_content 'Logout'
  end 


end
