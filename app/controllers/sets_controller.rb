class SetsController < ApplicationController
  def show
    @set = MagicSet.friendly.find(params[:id])
  end
end
