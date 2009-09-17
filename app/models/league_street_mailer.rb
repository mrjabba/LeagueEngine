class LeagueStreetMailer < ActionMailer::Base
  
  #when people sign up there email address is emailed to me.
  def emailme(email)
    @subject = "LeagueStreet signup"
    #@recipients = "trev@leaguestreet.com"
    @recipients = "teeerevor@gmail.com"
    @from = 'signup@leaguestreet.com'
    @sent_on = Time.now
    @body["email"] = email
  end
end
