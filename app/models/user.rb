class User < ActiveRecord::Base
  acts_as_authentic
  
  has_and_belongs_to_many :roles
  has_many :accounts_users
  
  def before_validation 
    self.password_confirmation = password
  end
end
