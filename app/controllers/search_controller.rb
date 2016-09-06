class SearchController < ApplicationController
  def autocomplete
    render json: MagicCard.search(params[:query], fields: ["name", "text"], match: :word_start, load: false).as_json
  end

  def normal
    search = params[:query].presence || "*"

    conditions = {}
    conditions[:cmc] = params[:cmc] if params[:cmc].present?
    conditions[:rarity] = params[:rarity] if params[:rarity].present?
    conditions[:types] = params[:types] if params[:types].present?
    conditions[:colors] = params[:colors] if params[:colors].present?

    @cards = MagicCard.search(search, fields: ["name", "text"], where: conditions, aggs: [:cmc, :rarity, :types, :colors], page: params[:page], per_page: 10)
  end
end
