class WelcomeController < ApplicationController
  before_filter :require_user
  
  layout 'nomenu'

  def index
  end
end
