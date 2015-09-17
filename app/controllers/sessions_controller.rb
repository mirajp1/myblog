class SessionsController < ApplicationController
	layout 'main'
	
	def new

	end

	def create
		@user=User.authenticate(params[:session][:email],params[:session][:password])
		if @user
			flash[:info] = "You've been logged in."
			log_in(@user)
			redirect_to @user
		else
			flash[:danger] = "There was a problem logging you in."
			render 'new'
		end			

	end

	def destroy
		if logged_in?
			log_out
			flash[:info] = "You've been logged out."
			redirect_to root_url
		else
			redirect_to root_url
		end
	end

end
