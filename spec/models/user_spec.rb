require 'spec_helper'

describe User do
  before(:each) do
    @user = Factory(:user)

    @account_1 = Factory(:account)
    @account_2 = Factory(:account)

    @user.accounts << @account_1
    @user.accounts << @account_2
  end

  it "should return all the active accounts for this user" do
    AccountsUser.update_all(["active = ?", true])
    @user.active_accounts.should == [@account_1, @account_2]
  end

  it "should return an empty array when there are no active accounts for this user" do
    @user.active_accounts.should == []
  end
end
