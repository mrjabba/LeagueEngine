class Player < ActiveRecord::Base
  has_many :team_members
  has_many :teams, :through => :team_members
  has_many :player_stats
  
  attr_accessor :same_as_me
  
  def name
    full_name
    #return full_name if middle_name.nil? && first_name.nil?  && last_name.nil? #mainly used when going from old naming system.
    #return first_name << " " << middle_name << " " << last_name if !middle_name.nil?   
    #return first_name << " " << last_name if middle_name.nil? && !first_name.nil?
    #return last_name  if middle_name.nil? && first_name.nil? # for people with one name.
  end
  
  def name=(name)
    self.full_name = name 
    name_arr = name.split
    split_name(name_arr) if !name.empty?
  end
  
  def split_name(name)
    case name.length
      when 1
        self.last_name = name[0]
      when 2
        self.first_name = name[0]
        self.last_name = name[1]
      when 3
        self.first_name = name[0]
        self.middle_name  = name[1]
        self.last_name = name[2]
    end  
  end
  
  def played_game?(game)
    ps = player_stats.first(:conditions => {:game_id => game})
    !ps.nil?
  end
  
  def self.all_players(account)
    players = []
    Team.all_teams(account).each do |t|
      t.team_members.each do |tm|
        players << tm.player
      end
    end
    players
  end
  
  def merge!
    if !self.same_as_me.empty?
      same_as_me.delete(self.id.to_s) #remove the players id that we want to keep, 
                                      #its a string because its passed as an string array from the browser
      self.same_as_me.each do |p|
        TeamMember.all(:conditions=>{:player_id => p}).each do |tm|
          if(TeamMember.exists?({:player_id => self.id, :team_id => tm.team_id}))
            tm.delete
          else
            tm.player_id = self.id
            tm.save
          end
        end
        
        
        #can update all here because it is less likely that they will have played or been on the same card.
        PlayerStat.update_all({:player_id => self.id}, {:player_id => p})

        Player.delete(p)
      end
    end
  end
end
