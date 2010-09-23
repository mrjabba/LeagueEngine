class League < ActiveRecord::Base
  belongs_to :account
  has_many :stats, :class_name => 'LeagueStat', :dependent => :destroy
  has_many :stat_types, :through => :stats
  has_many :teams, :dependent => :destroy
  has_many :games, :dependent => :destroy

  scope :default, :conditions =>{:account_id => 1, :name => 'DefaultLeague'}
  scope :latest, :order => :created_at

  def self.default(attributes = {})
    l = League.new({
      :name => 'DefaultLeague'
    }.with_indifferent_access.merge(attributes))

    # BLITZ Review: Defaults?
    if l.account
      #account needs to be set so that we know what league stats
      #we need to create for the default teams
      %w(Australia Brazil China Denmark).each do |team|
        t = Team.new({:name => team})
        l.account.stats.league.each do |stat|
          ls = LeagueStat.new({:stat_type => stat, :value => 0}) 
          # BLITZ Review: is this ok
          l.stats << ls
          t.league_stats << ls
        end
        l.teams << t
      end
    end
    return l
  end

  # BLITZ Review: plenty of duplication between this and self.default
  def new_team_attributes=(attrs)
    attrs.each do |team_attrs|
      t = Team.new({:name => team_attrs[:name]})
      account.stats.league.each do |stat|
       ls = LeagueStat.new({:stat_type => stat, :value => 0}) 
       self.stats << ls
       t.league_stats << ls
      end
      self.teams << t
    end
  end

  def existing_team_attributes=(attrs)
    teams.reject(&:new_record?).each do |team|
      attributes = attrs[team.id.to_s]
      if attributes
        team.update_attributes(attributes)
      else
        teams.delete(team)
      end
    end
  end
end
