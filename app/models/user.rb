class User < ActiveRecord::Base
	has_many :posts
	before_save {self.email = email.downcase}
	before_save {self.role ||= :member}
#	before_save {
#		capray = []
#		self.name.split.each do |x|
#			capray << x.capitalize
#		end
#		self.name = capray.join(" ")
#	}

	EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :name, length: {minimum: 1, maximum: 100}, presence: true
	validates :password, length: {minimum: 6}, presence: true
	validates :email,
		presence: true,
		uniqueness: {case_sensitive: false},
		length: {minimum: 3, maximum: 100},
		format: {with: EMAIL_REGEX}
	has_secure_password
	enum role: [:member, :admin, :moderator]
end