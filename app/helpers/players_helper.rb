module PlayersHelper

  def player_table_headings(stat, team)
    if(!stat.nil?)
      head = "<th>Player</th>"
      team.games(:order => "date ASC").each do |g|
        head += "<th>#{game.date}</th>"
      end
      return head
    else
      return "<th>Player</th><th></th>"
    end
  end

end
