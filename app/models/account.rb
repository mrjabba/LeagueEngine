class Account < ActiveRecord::Base
  validates_presence_of :name, :sport
  validates_uniqueness_of :name
  
  has_many :accounts_users
  has_many :users, :through => :accounts_users
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
    League.create_default(self)
  end
end
