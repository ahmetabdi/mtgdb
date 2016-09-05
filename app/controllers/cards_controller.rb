class CardsController < ApplicationController
  def show
    @card = MagicCard.friendly.find(params[:id])
    @also_seen_in = MagicCard.where(name: @card.name).where.not(id: @card.id)
  end
end
