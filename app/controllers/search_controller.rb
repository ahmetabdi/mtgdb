class SearchController < ApplicationController
	def autocomplete
    render json: Searchkick.search(params[:query],
    	index_name: [MagicCard, MagicSet],
      limit: 10,
      load: false,
      misspellings: {below: 5}
    ).as_json
  end
end
