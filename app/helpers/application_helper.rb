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

  def button_to_remove( klass, options ={})
    options = { :new_object => false,  :button_text => 'x'}.merge(options)

    render :partial => 'shared/button_to_remove', :locals => { :klass => klass,
                                                               :new_object => options[:new_object],  
                                                               :button_text => options[:button_text] }
  end
end
