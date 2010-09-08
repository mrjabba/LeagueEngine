class Account < ActiveRecord::Base
  validates_presence_of :name, :sport
  validates_uniqueness_of :name, :case_sensitive => false,
        :message => "already exists, please choose another name"
  validates_format_of :name, :with => /\A[a-z]|[A-Z]|[0-9]|\s+\z/,
      :message => "Can only contain characters a-z & 0-9"
  #validates_format_of :url, :with => /\A[a-z]|[0-9]+\z/,
  #    :message => "Can only contain alphnumeric charactgers"
    
  
  has_many :accounts_users
  has_many :users, :through => :accounts_users
  has_many :active_users, :through => :accounts_users, :source => :user, :conditions => ["active = ?", 1]
  has_one  :owner, :class_name => 'User', :foreign_key => "owner_id"
  has_many :leagues
  has_many :games, :through => :leagues
  has_many :teams, :through => :leagues
  has_many :players, :through => :teams
  belongs_to :sport
  has_many :stats, :class_name => 'StatType'
  
  named_scope :default, :conditions => { :id => 1 }
  
  attr_accessor :other
  
  def other=(other)
    #the plan is to send myslef an email when an other is set and
  end
  
  def create_default_data
    StatType.create_defaults(self)
    League.default.first.clone(self)
  end
end
