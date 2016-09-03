class SetsController < ApplicationController
	def index
		@sets = MagicSet.all
	end
	
  def show
    @set = MagicSet.friendly.find(params[:id])
  end
end
