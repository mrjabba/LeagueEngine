# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def format_date(date)
    return date.strftime("%I:%M%p") if date.year == Time.now.year && date.month == Time.now.month && date.day == Time.now.day
    return date.strftime("%d %b") if date.year == Time.now.year
    return date.strftime("%d %b %y")
  end
  
  def button_to_add( klass, partial, button_text = '+')
    render :partial => 'shared/button_to_add', :locals => { :klass => klass, 
                                                       :partial => partial,
                                                       :button_text => button_text }
  end

  def button_to_remove( klass, button_text = 'x')
    render :partial => 'shared/button_to_remove', :locals => { :klass => klass, 
                                                               :button_text => button_text }
  end
end
