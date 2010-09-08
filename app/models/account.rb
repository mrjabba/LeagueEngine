class Account < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name, :case_sensitive => false,
        :message => "already exists, please choose another name"
  validates_format_of :name, :with => /^[a-zA-Z0-9\s]+$/,
      :message => "Can only contain characters a-z, A-Z & 0-9"
  #validates_format_of :url, :with => /^[a-zA-Z0-9\s]+$/,
  #    :message => "Can only contain alphnumeric charactgers"
  validate :other_sport_name_validation

  has_many   :accounts_users
  has_many   :users, :through => :accounts_users
  has_many 	 :active_users, :through => :accounts_users, :source => :user, :conditions => ["active = ?", 1]
  has_one    :owner, :class_name => 'User', :foreign_key => "owner_id"
  has_many   :leagues
  has_many   :games, :through => :leagues
  has_many   :teams, :through => :leagues
  has_many   :players, :through => :teams
  has_many   :stats, :class_name => 'StatType'
  belongs_to :sport

  def other_sport_name_validation
    if other_sport_name.present? and sport.present?
      errors.add(:other_sport_name, 'should be empty if a sport is selected')
      return
    end

    if other_sport_name.blank? and sport.blank?
      errors.add(:other_sport_name, 'or sport should be provided')
      return
    end
  end

  def self.default(attributes = {})
    a = Account.new({
      :name => 'Default',
      :other_sport_name => 'Other Sport'
    }.merge(attributes))

    a.stats   << StatType.default
    a.leagues << League.default

    return a
  end
end
