class SearchController < ApplicationController
	def autocomplete
    render json: Searchkick.search(params[:query],
    	index_name: [MagicCard, MagicSet],
    	fields: [:name],
    	match: :word_start,
      limit: 10,
      load: false,
      misspellings: {below: 5}
    ).as_json
  end
end
