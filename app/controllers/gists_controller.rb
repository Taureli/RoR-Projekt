class GistsController < ApplicationController
  before_action :signed_in_user
  before_action :set_gist, only: [:destroy]

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
    @gist.destroy
    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
  end

  private
    def set_gist
      @gist = Gist.find(params[:id])
    end

    def gist_params
      params.require(:gist).permit(:snippet, :lang, :description)
    end
end
