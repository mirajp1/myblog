class UsersController < ApplicationController
	layout 'main'

	def new
		@user=User.new
	end

	def show
		@user=current_user
		if !@user
			flash[:danger] = "Please Login to continue."
			redirect_to login_path
		
		elsif logged_in? && params[:id].to_i != session[:user_id]
			flash[:danger] = "Trying to access other's data. Redirecting"
			redirect_to @user
		end
	end

	def create
		@user=User.new(user_params)
		if @user.save
			flash[:success] = "Welcome!"
			log_in(@user)
			redirect_to current_user
		else
			render 'new'
		end
	end

	private
	def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

end
