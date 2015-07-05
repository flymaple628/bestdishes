class DishCommentsController < ApplicationController

	before_action :authenticate_user!,:except=>[:index]

	before_action :dish_one
	before_action :comment_all,:only=>[:index]
	before_action :get_my_comment,:only=>[:update,:destroy]

	#GET /dishes/:id/comments/
	def index
		@dish.increment!(:viewed)

		if current_user && params[:id]
			@comment = current_user.comments.find(params[:id])
		else
			@comment = Comment.new
		end

	end

	#POST /dishes/:id/comments/
	def create
		@comment=@dish.comments.build(comment_params)
		@comment.user = current_user
		state=@comment.save
		if state
			@comment.dish.touch(:last_commented_at)
		end
		respond_to do |format|
			format.html {
				if state
				redirect_to dish_comments_path(@dish)
				else
				comment_all
				render :action=>:index
				end
			}
			format.js
		end
	end

	#PATCH /dishes/:dish_id/comments/:id
	def update
		if @comment.update(comment_params)
			redirect_to dish_comments_path(@dish)
		else
			comment_all
			render :action=>:index
		end
	end

	def destroy
		@comment.destroy
		respond_to do |format|
		  format.html {redirect_to :back}
		  format.js {render :text =>"$('#item-list#{params[:id]}').html('');"}
		end

	end

	protected

	def dish_one
		@dish=Dish.find(params[:dish_id])
	end

	def get_my_comment
		@comment = current_user.comments.find(params[:id])
	end

	def comment_all
		@comments= @dish.comments

		case params[:order]
		when 'tasted'
			sort_by='tasted desc'
		when 'acid'
			sort_by='acid desc'
		when 'sweet'
			sort_by='sweet desc'
		when 'bitter'
			sort_by='bitter desc'
		when 'spicy'
			sort_by='spicy desc'
		when 'salt'
			sort_by='salt desc'
		else
			sort_by='id desc'
		end
		@comments=@comments.where(:status=>2)
		@comments=@comments.order(sort_by)
		@comments=@comments.page(params[:page]).per(10)
	end

	def comment_params
		params.require(:comment).permit(:tasted,:acid,:sweet,:bitter,:spicy,:salt,:comment,:status)
	end
end
