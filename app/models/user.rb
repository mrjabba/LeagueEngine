class User < ActiveRecord::Base
  acts_as_authentic do |c|
    c.require_password_confirmation = false
  end  
  
  has_and_belongs_to_many :roles
  has_many :accounts_users
  
end
