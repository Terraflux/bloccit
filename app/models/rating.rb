class Rating < ActiveRecord::Base
	enum severity: [:PG, :PG13, :R]
	belongs_to :rateable, polymorphic: true
	has_many :topics, through: :rateable
	has_many :posts, through: :rateable
	def self.update_rating(rating_string)
		unless rating_string.nil? || rating_string =/= ("PG" || "PG13" || "R")
			new_rating = rating_string
		end
	end
end