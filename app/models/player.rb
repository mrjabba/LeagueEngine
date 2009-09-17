class Player < ActiveRecord::Base
  has_many :team_members
  has_many :player_stats
  
  def played_game?(game)
    ps = player_stats.first(:conditions => {:game_id => game.id})
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
  
  def self.merge!(players, pname)
    count = 0
    keptID = 0
    players.each do |deletedID|
      if keptID != deletedID #incase duplicate player.ids have been submitted and the dup is the player who we are keeping
        if keptID == 0
          keptID = deletedID
        else
          if(Player.exists?(deletedID))   
            
            #can't just update all within TeamMembers table because it's more then likely that when merging two players
            #they are the same person but listen on cards under different names.
            TeamMember.all(:conditions=>{:player_id => deletedID}).each do |tm|
              if(TeamMember.exists?({:player_id => keptID, :team_id => tm.team_id}))
                tm.delete
              else
                tm.player_id = keptID #update({:player_id => keptID}, {:player_id => deletedID})
                tm.save
              end
            end
      
            #can update all here because it is less likely that they will have played or been on the same card.
            PlayerStat.update_all({:player_id => keptID}, {:player_id => deletedID})
      
            Player.delete(deletedID)
          end
        end
      end
      count = count + 1
    end
    p = Player.find(keptID)
    p.name = pname
    p.save
  end
end
