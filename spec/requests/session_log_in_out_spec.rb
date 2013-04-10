describe "Sessions" do
require "spec_helper"
   # log in

   describe "login" do

      describe "failure" do

       it "should not log the user in" do
         visit login_path
         # puts response.body
         fill_in 'session_email',    with: ""
         fill_in 'session_password', with: "" 
         click_button
         response.should have_selector('div.login_error', content: "Invalid")
         response.should render_template('sessions/new')
       end

     end

      describe "success" do
        
        it "should sign a user in AND out" do
          user = Factory(:user)
          visit login_path
          fill_in 'session_email',    with: user.email
          fill_in 'session_password', with: user.password
          click_button
          controller.should be_logged_in
          click_link "Log out"
          controller.should_not be_logged_in
        end
        
      end

   end

 end