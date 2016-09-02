class SearchController < ApplicationController
	def autocomplete

		# fresh_products = MagicSet.search(params[:query], execute: false, limit: 2)
		# frozen_products = MagicCard.search(params[:query], execute: false, limit: 2)
		# Searchkick.multi_search([fresh_products, frozen_products])


# MagicSet.search(params[:query], {
      # fields: ["name^5"],
      # limit: 10,
      # load: false,
      # misspellings: {below: 5}
#     })
    render json: Searchkick.search(params[:query], 
    	index_name: [MagicCard, MagicSet],
      limit: 10,
      load: false,
      misspellings: {below: 5}
    ).as_json#MagicCard.search(params[:query]).as_json
  end
end