class ArticlesController < ApplicationController
	layout 'main'

	before_action :require_login, only: [:new,:create,:destroy,:edit]

	def new
		@user = current_user
		if !@article
			@article = @user.articles.build
		end
	end

	def create
		@user = current_user
		@article= @user.articles.build(article_params)
		if @article.save		
			flash[:info] = "Article Published"
			redirect_to @article
		else
			render 'new'
		end
	end
	
	def show
		@user=current_user
		@article=Article.find_by(id: params[:id])
		if !@article
			flash[:danger]="Invalid page accessed! Redirecting to home."
			redirect_to root_url
		end
	end
	
	def index
		
	end

	def edit
		@user=current_user
		@article=Article.find(params[:id])
		if !@article
			flash[:danger]="Invalid page accessed! Redirecting to home."
			redirect_to root_url
		else
			if @user != @article.author
				flash[:danger]="You are not the author of this page.Can't edit. Redirecting"
				redirect_to @user
			end
		end
		
	end

	private
	def article_params
		params.require(:article).permit(:title,:body)
	end

end
