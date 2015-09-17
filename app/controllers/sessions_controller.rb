class SessionsController < ApplicationController
	layout 'main'
	before_action :restrict_login_signup, only: [:new,:create]
	
	def new
		
	end

	def create
		@user=User.authenticate(params[:session][:email],params[:session][:password])
		if @user
			flash[:info] = "You've been logged in."
			log_in(@user)
			redirect_to @user
		else
			flash[:danger] = "Invalid Email/Password."
			render 'new'
		end			

	end

	def destroy
		log_out
		flash[:info] = "You've been logged out."
		redirect_to root_url
	end
	
	
end
