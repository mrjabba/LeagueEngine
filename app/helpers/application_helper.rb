# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def format_date(date)
    return date.strftime("%I:%M%p") if date.year == Time.now.year && date.month == Time.now.month && date.day == Time.now.day
    return date.strftime("%d %b") if date.year == Time.now.year
    return date.strftime("%d %b %y")
  end
end
