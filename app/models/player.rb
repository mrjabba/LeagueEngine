class Player < ActiveRecord::Base
  has_many :team_members
  has_many :teams, :through => :team_members
  has_many :player_stats
  
  attr_accessor :same_as_me
  
  #def name=(name)
   # store_name(name.split(''))
  #end
  
  #def name
   # return first_name << " " << middle_name << " " << last_name if !middle_name.empty? && !first_name.empty? > 0    
    #return first_name << " " << last_name if middle_name.empty?    
  #end
  
  #def store_name(name)
   # 
  #end
  
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
