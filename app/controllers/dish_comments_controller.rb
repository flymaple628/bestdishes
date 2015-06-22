class DishCommentsController < ApplicationController
	before_action :dish_one
	before_action :comment_all,:only=>[:index,:create,:update]
	before_action :comment_one,:only=>[:update,:delete]
	#GET /dishes/:id/comments/
	def index
		if params[:id]
			@comment=Comment.find(params[:id])
		else
			@comment=Comment.new
		end
	end


	#POST /dishes/:id/comments/
	def create
		@comment=@dish.comments.build(comment_params)
		if @comment.save
			redirect_to dish_comments_path
		else
			render :action=>:index
		end
	end

	#PATCH /dishes/:dish_id/comments/:id
	def update
		if @comment.update(comment_params)
			redirect_to dish_comments_path(:id=>@comment.id)
		else
			render :action=>:index
		end
	end


	def dish_one
		@dish=Dish.find(params[:dish_id])
	end

	def comment_one
		@comment=Comment.find(params[:id])
	end

	def comment_all
		@comments=Comment.where(dish_id: params[:dish_id])
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
