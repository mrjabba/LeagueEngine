require 'spec_helper'

describe AccountsUser do
  before(:each) do
  end

  it "should return the active account" do
    account_user = Factory(:accounts_user)
    AccountsUser.find_active_account(account_user.user).should == account_user
  end

  it "should not return any account" do
    account_user = Factory(:accounts_user, :active => 0)
    AccountsUser.find_active_account(account_user).should be_blank
    AccountsUser.should have(1).record
  end

  it "should find the row" do
    account_user = Factory(:accounts_user)
    AccountsUser.find_row(account_user.account, account_user.user).should == account_user
  end

  it "should return true for an active user" do
    account_user = Factory(:accounts_user)
    AccountsUser.is_active(account_user.account, account_user.user).should be_true
  end

  it "should return false for an inactive user" do
    account_user = Factory(:accounts_user, :active => false)
    AccountsUser.is_active(account_user.account, account_user.user).should_not be_true
  end
end
