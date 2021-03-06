class CommentsController < ApplicationController
	layout 'main'
	before_action :require_login,only: [:create,:edit,:update,:destroy]

	
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
			flash.now[:danger] = "Comment not added.Error!See below"
			render 'articles/show'				#render becuase to show error
		end
	end

	def edit
		@user=current_user
		@article
		@comment = Comment.find_by(id: params[:id])
		if !@comment || (@comment.commentor != @user && !@user.admin?)
			flash[:info] = "Invalid page accessed"
			redirect_to @user		
		end
	end

	def update
		@user=current_user
		@comment = Comment.find_by(id: params[:id])
		@article
		
		if	(@comment.commentor == @user || @user.admin?) && @comment.update(comment_params)
			flash[:info] = "Comment updated"
			redirect_to @comment.article
		else
			flash.now[:danger] = "Cant Update.Not authorised or errors below"
			render 'edit'
		end
	end

	def destroy
		@user = current_user
		@comment=Comment.find_by(id: params[:id])
		@article = @comment.article
		if @comment && (@comment.commentor = @user || @user.admin? )
			if	@comment.destroy
				flash[:info] = "Comment deleted"+params[:comment_id].to_s
			else
				flash[:info] = "Some error in Destroying"
			end			
		else
			flash[:info] = "Can't delete article.Unauthorised"
		end
		redirect_to @article
					
	end

	private
	def comment_params
		params.require(:comment).permit(:body)
  	end


end
