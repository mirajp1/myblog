class ArticlesController < ApplicationController
	layout 'main'
	

	before_action :require_login, only: [:new,:create,:destroy,:edit,:update]

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
		elsif !@comment								#check if errors from comments#create
			@comment=@article.comments.build
		end
		
	end
	
	def index
		@user=current_user
	end

	def edit
		@temp_user=current_user
		@user
		@article=Article.find(params[:id])
		if !@article
			flash[:danger]="Invalid page accessed! Redirecting to home."
			redirect_to root_url
		else
			if @temp_user != @article.author && !@temp_user.admin?
				flash[:danger]="You are not the author of this page.Can't edit. Redirecting"
				redirect_to @temp_user
			end
		end
		
	end

	def update
		@temp_user=current_user
		@user
		@article=Article.find(params[:id])
		if @article.update(article_params)
			flash[:info]="Article updated!"
			redirect_to @article
		else
			render 'edit'
		end
	end

	def destroy
		@user = current_user
		@article=Article.find_by(id: params[:id])
		if @article && (@article.author = @user || @user.admin? )
			if	@article.destroy
				flash[:info] = "Article deleted"
				redirect_to my_articles_path
			else
				flash[:info] = "Some error"
				redirect_to my_articles_path
			end			
		else
			flash[:info] = "Can't delete article.Some error"
			redirect_to @user
		end
					
	end

	private
	def article_params
		params.require(:article).permit(:title,:body)
	end

end
