class StaticPagesController < ApplicationController
	
  def home
  	@gist = current_user.gists.build if signed_in?
  end

  def help
  end

  def about
  end

  def contact
  end

end
