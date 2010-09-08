require 'spec_helper'

describe Account do
  before(:each) do
    @user_1 = Factory(:user)
    @user_2 = Factory(:user)

    @account = Factory(:account)
    @account.users << @user_1
    @account.users << @user_2
  end

  it "should return any and all active users for this account" do
    AccountsUser.update_all(["active = ?", true])
    @account.active_users.should == [@user_1, @user_2]
  end

  it "should return an empty array when there are no active users for this account" do
    @account.active_users.should == []
  end
end
