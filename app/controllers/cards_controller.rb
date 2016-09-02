class CardsController < ApplicationController
  def show
    @card = MagicCard.friendly.find(params[:id])
  end
end
