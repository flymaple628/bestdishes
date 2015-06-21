class DishCommentsController < ApplicationController
	before_action :dish_one
	before_action :comment_all,:only=>[:index,:create,:update]

	#GET /dishes/:id/comments/
	def index

		@comment=Comment.new
	end


	#POST /dishes/:id/comments/
	def create
		@comment=Comment.new(comment_params)
		if @comment.save
			redirect_to dish_comments_path
		else
			render :action=>:index
		end
	end


	def dish_one
		@dish=Dish.find(params[:dish_id])
	end

	def comment_all
		@comments=Comment.all
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

		@comments=@comments.order(sort_by)
		@comments=@comments.page(params[:page]).per(10)
	end

	def comment_params
		params.require(:comment).permit(:tasted,:acid,:sweet,:bitter,:spicy,:salt,:comment)
	end
end
