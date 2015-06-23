class DishesController < ApplicationController
	before_action :dish_one,:only=>[:update,:destroy]
	before_action :dish_all,:only=>[:index,:update]

	#GET /dishes/
	def index
		if params[:id]
			dish_one
		else
			@dish=Dish.new
		end
	end

	#GET /dishes/new
	def new
		@dish=Dish.new
	end

	#POST /dishes/
	def create
		@dish=Dish.new(dish_params.merge(:user_id => current_user.id))
		# render :text=>dish_params.inspect
		if @dish.save
			redirect_to dishes_path
		else
			render :action=>:new
		end
	end

	#Patch /dishes/:id/
	def update
		if @dish.update(dish_params)
			redirect_to dishes_path(:id=>@dish.id)
		else
			render :action=>:index
		end
	end
	#delete /dishes/:id
	def destroy
		@dish.destroy
		redirect_to dishes_path
	end

	def dish_one
		@dish=Dish.find_by_id(params[:id])
	end
	def dish_all
		@dish_count=Comment.group(:dish_id).count()
		@dishes=Dish.all

		if ['name','price'].include?params[:order]
			sort_by=params[:order]
		else
			sort_by=:id
		end
		@dishes=@dishes.order(sort_by)
	end

	def dish_params
		params.require(:dish).permit(:name,:price,:short_des,:user_id,:tag_ids=>[])
	end
end
