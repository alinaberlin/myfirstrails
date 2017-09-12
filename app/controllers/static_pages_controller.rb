class StaticPagesController < ApplicationController
	def landing_page
    	#@products = Product.limit(3)
    	redirect_to products_url
  	end
end

