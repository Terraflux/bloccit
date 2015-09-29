module UsersHelper

	def user_has_comments?(user)
		if !@user.comments.nil?
			render @user.comments
		else
			"#{user.name} has not submitted any posts yet."
		end
	end
end
