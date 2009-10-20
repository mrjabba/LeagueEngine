module GamesHelper
  def render_day(date, selected_date, current_month)
    today = Time.now
    if !selected_date.nil? 
      return "<a href='#' class='selected'>#{date.day}</a>" if date.day == selected_date.day && date.mon == selected_date.mon && date.year == selected_date.year
    end
    return "<a href='#' class='today'>#{date.day}</a>" if date.day == today.day && date.mon == today.mon && date.year == today.year 
    return "<a href='#' class='dull'>#{date.day}</a>" if date.mon != current_month
    if date.wday > 0 && date.wday < 6
       return "<a href='#' >#{date.day}</a>"
    else
      return "<a href='#' class='wend'>#{date.day}</a>"
    end 
  end
  
  def fields_for_player_stat(player_stat, &block)
    prefix = player_stat.new_record? ? 'new' : 'existing'
    fields_for("game[#{prefix}_player_stats][]", player_stat, &block)
  end
end
