module SessionsHelper
	
	def current_user
		@current_user ||= User.find_by(id: session[:user_id])
	end
	
	def logged_in?
		!current_user.nil?		
	end

	def log_in(user)
		session[:user_id]=user.id
	end

	def log_out
		session.delete(:user_id)
		@current_user=nil
	end

	#restrict login and signup while logged_in 
	def restrict_login_signup
		if logged_in?
			flash[:danger] = "You have to Logout before trying to login/signup"
			redirect_to current_user
		end
	end

	#restrict showing profile if not logged_in 
	def require_login
		if !logged_in?
			flash[:danger] = "You have to Login before trying to view profile"
			redirect_to login_path
		end
	end

end
