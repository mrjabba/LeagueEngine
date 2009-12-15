class Account < ActiveRecord::Base
  validates_presence_of :name, :sport
  validates_uniqueness_of :name
  
  #has_and_belongs_to_many :users
  has_many :accounts_users
  has_many :users, :through => :accounts_users
  has_many :leagues
  has_many :games, :through => :leagues
  has_many :teams, :through => :leagues
  has_many :players, :through => :teams
  belongs_to :sport
  
  attr_accessor :other
  
  def other=(other)
    #the plan is to send myslef an email when an other is set and
  end
  
  def self.is_active() 
    return AccountsUser.is_active(self.id)
  end
  
  def self.get_active_account(user)
     activeAcc = AccountsUser.find_active_account(user)
     return Account.find(activeAcc.account_id)
  end
end
