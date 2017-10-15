class Product < ApplicationRecord
	has_many :orders
    has_many :comments
    validates :name, presence:true
    validates :price,  numericality: { only_integer: true } 
	def self.search(search_term)
	  Product.where("lower(name) LIKE lower(?)", "%#{search_term}%")
	end
	def highest_rating_comment
  		comments.rating_desc.first
 	end
 	def lowest_rating_comment
  		comments.rating_asc.first
 	end
 	def average_rating
    	comments.average(:rating).to_f
    end
end

#validation is importing  every comment record should be saved with a user ID,
# a product ID, and a message,
# it's a good idea to validate the presence of all of those attributes 
#(for the product and user relations, we validate the relation, not the name of the database field, so we use the :user symbol
# instead of :user_id). This way, we'll ensure that the rating must be an integer value. 
# ex: validates :product, presence: true