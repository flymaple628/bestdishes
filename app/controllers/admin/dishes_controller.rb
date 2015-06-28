class Admin::DishesController < ApplicationController
	before_action :authenticate_admin!
  layout "admin"
	before_action :dish_one,:only=>[:update,:destroy]
	before_action :dish_all,:only=>[:index,:update,:draft]

	#GET /dishes/
	def index
		#@dishes=@dishes.where(:status=>2)

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
		#@dishes=@dishes.where(:status=>1)
		render :action=>:index
	end

	#GET/dishes/category/:id
	def tag
		# @tag=Tag.new
		if(params[:id].nil?)
			@tag=Tag.new
		else
			@tag=Tag.find(params[:id])
		end
		#render :html=>@tag.inspect
		@tags=Tag.all
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

	#POST /dishes/tag/
	def tagpost
		if(params[:id].nil?)
		@tag=Tag.new(tag_params)
		@tag.save
		else
			@tag=Tag.find(params[:id])
			@tag.update(tag_params)
		end
		#render :text=>params
		redirect_to tag_admin_dishes_path
	end

	def dish_one
		@dish=Dish.find_by_id(params[:id])
	end
	def dish_all
		# users = User.joins("LEFT JOIN tickets ON users.id = tickets.user_id").select("users.*, count(tickets.id) as ticket_count").group("users.id")
		# users.first.ticket_count

		# @dish_count=Comment.group(:dish_id).count()

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
