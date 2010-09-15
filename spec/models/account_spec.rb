require 'spec_helper'

describe Account do

  before do
    @sport = Factory(:sport)
    @account = Account.new(valid_attributes)
  end

  def valid_attributes(options = {})
    {
      :name => 'My Account',
      :sport => @sport,
      :other_sport_name => nil
    }.merge(options)
  end

  describe 'associations' do

    it do
      @account.should have_many(:accounts_users)
      @account.should have_many(:users)
      @account.should have_many(:leagues)
      @account.should have_many(:games)
      @account.should have_many(:teams)
      @account.should have_many(:players)
      @account.should have_many(:stats)
      @account.should belong_to(:sport)
      @account.should belong_to(:owner)
    end

  end

  context 'validation' do

    it do
      @account.should validate_presence_of(:name)
      #@account.should validate_uniqueness_of(:name)
    end

    describe 'name' do

      it 'should only contain alphanumeric characters' do
        Account.new(valid_attributes).should be_valid
        Account.new(valid_attributes(:name => 'ASD98xzz')).should be_valid
        Account.new(valid_attributes(:name => 'ASD 98 xzz')).should be_valid
        Account.new(valid_attributes(:name => 'ASD 98xzz$')).should_not be_valid
        Account.new(valid_attributes(:name => '@ASD98 xzz')).should_not be_valid
        Account.new(valid_attributes(:name => 'ASD98 xzz-')).should_not be_valid
      end

    end

    describe 'other sport' do

      it "should be nil if a sport is provided" do
        @account.should be_valid

        @account.other_sport_name = 'Basket Ball'
        @account.should_not be_valid
        @account.errors[:other_sport_name].should_not be_nil
      end

      it "should be provided if no sport is provided" do
        @account.sport = nil
        @account.other_sport_name = 'My effing sport'
        @account.should be_valid

        @account.other_sport_name = ''
        @account.should_not be_valid
        @account.errors[:other_sport_name].should_not be_nil
      end

    end # other sport

  end # validation

  describe "account.active_users" do
    before do
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

end
