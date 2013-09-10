require 'spec_helper'

describe "PasswordResets" do

  it "emails the user when a password reset is requested" do
    user = FactoryGirl.create(:user)
    visit login_path
    click_button "Log in"
    click_link "forgotten"
    fill_in "email", :with => user.email
    click_button 'reset'
    response.should have_selector('div', content: "Please check")
    ActionMailer::Base.deliveries.last.to.should include(user.email)
  end

  it "does not email an invalid user when a password reset is requested" do
    # reset mail deliveries array
    ActionMailer::Base.deliveries = []
    visit login_path
    click_button "Log in"
    click_link "forgotten"
    fill_in "email", :with => "nobody@example.com"
    click_button "reset"
    response.should have_selector('div', content: "Please check")
    ActionMailer::Base.deliveries.last.should be_nil
  end
  
  it "updates the user password when confirmation matches" do
    user = FactoryGirl.create(:user, :password_reset_token => "something", :password_reset_sent_at => 1.hour.ago)
    visit edit_password_reset_path(user.password_reset_token)
    fill_in "user[password]", :with => "password"
    click_button "Update Password"
    response.should have_selector('div', content: "Something's gone wrong")
    fill_in "user[password]", :with => "password"
    fill_in "user[password_confirmation]", :with => "password"
    click_button "Update Password"
    response.should have_selector('div', content: "Password has been reset")
  end

  it "reports when password token has expired" do
    user = FactoryGirl.create(:user, :password_reset_token => "something", :password_reset_sent_at => 5.hour.ago)
    visit edit_password_reset_path(user.password_reset_token)
    fill_in "user[password]", :with => "password"
    fill_in "user[password_confirmation]", :with => "password"
    click_button "Update Password"
    response.should have_selector('div', content: "Password reset has expired")
  end

  it "raises record not found when password token is invalid" do
    lambda {
      visit edit_password_reset_path("invalid")
    }.should raise_exception(ActiveRecord::RecordNotFound)
  end
end
