class CommentsController < ApplicationController
	layout 'main'
	before_action :require_login,only: [:create,:edit,:update]

	
	def new 
		
	end

	def create

		@user=current_user
		@comment=@user.comments.build(:body => params[:comment][:body])
		@article=Article.find(params[:article_id])
		@comment.article=@article
		
		if  @comment.save
			flash[:info] = "Comment Added"
			redirect_to @article
		else
			flash[:danger] = "Comment not added.Error!See below"
			redirect_to @article
		end
	end

end
