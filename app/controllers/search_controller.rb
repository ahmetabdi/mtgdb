class SearchController < ApplicationController
	def autocomplete
    render json: MagicCard.search(params[:query], fields: ["name", "text"], load: false).as_json
      # aggs: {color: {order: {"_term" => "asc"}}}
    # ).as_json
    # render json: Searchkick.search(params[:query],
    # 	index_name: [MagicCard, MagicSet],
    # 	fields: [:name, :text],
    # 	match: :word_start,
    #   limit: 10,
    #   load: false,
    #   misspellings: {below: 5}
    # ).as_json
  end
end
