class Calendar
  attr_reader :selected_date, :today, :month
  
  def initialize(m = nil, sd = nil)
    @month = m
    @selected_date = sd
    @today = Time.now
  end
  
  def render_day(date)
    if !@selected_date.nil? 
      return "<a href='#' class='selected'>#{date.day}</a>" if date.day == @selected_date.day && date.mon == @selected_date.mon && date.year == @selected_date.year
    end
    return "<a href='#' class='today'>#{date.day}</a>" if date.day == @today.day && date.mon == @today.mon && date.year == @today.year 
    return "<a href='#' class='dull'>#{date.day}</a>" if date.mon != @month
    if date.wday > 0 && date.wday < 6
       return "<a href='#' >#{date.day}</a>"
    else
      return "<a href='#' class='wend'>#{date.day}</a>"
    end 
  end
end