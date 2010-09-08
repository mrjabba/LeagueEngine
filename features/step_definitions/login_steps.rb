Given /^I am and admin user$/ do
  @user = Factory(:user, :password => 'test123')
  @account = @user.accounts << Factory(:account)
  When "I go to login_path"
  And "I fill in \"user_session_username\" with \"#{@user.username}\""
  And "I fill in \"user_session_password\" with \"test123\""
end