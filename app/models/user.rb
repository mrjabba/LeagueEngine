class User < ActiveRecord::Base
  #validates_length_of :name, :minimum => 2
  #validates_uniqueness_of :email, :case_sensitive => false
  
  acts_as_authentic do |c|
    c.require_password_confirmation = false
  end  
  
  has_and_belongs_to_many :roles
  has_many :accounts_users
  has_many :accounts, :through => :accounts_users
  has_many :active_accounts, :through => :accounts_users, :source => :account, :conditions => ["active = ?", 1]
  
end
