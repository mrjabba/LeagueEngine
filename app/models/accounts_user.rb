class AccountsUser < ActiveRecord::Base
  belongs_to :account
  belongs_to :user
  belongs_to :role

  def self.find_active_account(user)
    return AccountsUser.where("active = 1 and user_id = #{user.id}").first
  end
end
