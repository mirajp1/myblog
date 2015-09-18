class UsersController < ApplicationController
	layout 'main'
	before_action :restrict_login_signup, only: [:new,:create]
	before_action :require_login,only: [:show,:my_articles]

	def new
		@user=User.new
	end

	def show
		#only logged_in users will be able to reach here due to before_action Action Controller above
 		@user=current_user
		if !@user.admin? && params[:id].to_i != session[:user_id]
			flash[:danger] = "Trying to access other's data. Redirecting"
			redirect_to @user
		elsif @user.admin?
			usertemp = User.find_by(id: params[:id])
			if !usertemp
				flash[:danger] = "No user data for that id. Redirecting"
				redirect_to @user
			else
				@user=usertemp
			end
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

	def my_articles
		
	end

	private
	def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

end
