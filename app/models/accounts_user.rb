class AccountsUser < ActiveRecord::Base
  belongs_to :account
  belongs_to :user

  def self.find_active_account(user)
    return AccountsUser.find(:first,
                             :conditions => ["active = 1 and user_id = :user" ,
                             {:user => user}])
  end

  def self.find_row(account, user)
    return AccountsUser.find(:first,
                             :conditions => ["account_id = :account and user_id = :user" ,
                             {:account => account, :user => user}])
  end

  def self.is_active(account, user)
    au = AccountsUser.find(:first,
                             :conditions => ["account_id = :account and active = 1 and user_id = :user" ,
                             {:account => account, :user => user}])
    return !au.blank?
  end
end
