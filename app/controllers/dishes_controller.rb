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
		@dish=Dish.new(dish_params)
		if @dish.save
			redirect_to dishes_path
		else
			render :action=>:new
		end
	end

	#Patch /dishes/:id/
	def update
		if @dish.update
			redirect_to dishes_path
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
		@dishes=Dish.all
	end

	def dish_params
		params.require(:dish).permit(:name,:price,:short_des)
	end
end
