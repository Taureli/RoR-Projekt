class GistsController < ApplicationController
  before_action :signed_in_user

  def index
  end

 def create
    @gist = current_user.gists.build(gist_params)
    if @gist.save
      flash[:success] = "Gist created!"
      redirect_to root_url
    else
      render 'static_pages/home'
    end
  end

  def destroy
  end

  private

    def gist_params
      params.require(:gist).permit(:snippet, :lang, :description)
    end
end
