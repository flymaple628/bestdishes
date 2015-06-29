class Admin::DishesController < ApplicationController
	before_action :authenticate_admin!
  layout "admin"
	before_action :dish_one,:only=>[:update,:destroy]
	before_action :dish_all,:only=>[:index,:update,:draft]

	#GET /dishes/
	def index


		if current_user
			if params[:id]
				dish_one
			else
				@dish=Dish.new
			end
		end
	end

	#GET /dishes/new
	def new
		@dish=Dish.new
	end

	#GET /dishes/draft
	def draft

		render :action=>:index
	end


	#POST /dishes/
	def create
		@dish=Dish.new(dish_params.merge(:user_id => current_user.id))

		if @dish.save
			redirect_to admin_dishes_path
		else
			render :action=>:new
		end
	end

	#Patch /dishes/:id/
	def update
		if @dish.update(dish_params)
			redirect_to admin_dishes_path(:id=>@dish.id)
		else
			render :action=>:index
		end
	end
	#delete /dishes/:id
	def destroy
		@dish.destroy
		redirect_to admin_dishes_path
	end




	def dish_one
		@dish=Dish.find_by_id(params[:id])
	end
	def dish_all

		@dishes=Dish.joins("LEFT JOIN comments ON dishes.id=comments.dish_id").select("dishes.*,count(comments.id) as comment_count").group("dishes.id")

		if ['name','price','comment_countd','updated_at'].include?params[:order]
			if params[:order]=='comment_countd'
				sort_by=params[:order]+' desc'
			else
				sort_by=params[:order]
			end
		else
			sort_by=:id
		end

		@dishes=@dishes.order(sort_by)
		@dishes=@dishes.page(params[:page]).per(10)
	end

	def tag_params
		params.require(:tag).permit(:name)
	end

	def dish_params
		params.require(:dish).permit(:name,:price,:short_des,:user_id,:status,:tag_ids=>[])
	end
	protected

end
