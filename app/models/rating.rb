class Rating < ActiveRecord::Base
	enum severity: [:PG, :PG13, :R]
	belongs_to :rateable, polymorphic: true
	has_many :topics, through: :rateable
	has_many :posts, through: :rateable
	def self.update_rating(rating_string)
		unless rating_string.nil? || !(["PG", "PG13", "R"].include?(rating_string)) #rating_string != "GP" && rating_string != "PG13"....  ("PG" || "PG13" || "R")
			self.severity = rating_string
		end
	end
end