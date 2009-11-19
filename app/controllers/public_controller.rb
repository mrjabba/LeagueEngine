class PublicController < ApplicationController
  layout "blank"
  before_filter :require_user
  
  def index
    render(:signup)
  end
  
  def signup
    @email = params[:email]
    if request.post?
      email = LeagueStreetMailer.create_emailme(@email) 
      email.set_content_type("text/html") 
      LeagueStreetMailer.deliver(email) 
      #render(:text => "<pre>" + email.encoded + "</pre>")
      redirect_to :action => :thanks
    end
  end
  
  def thanks
  end
end
