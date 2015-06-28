class DishesController < ApplicationController
	before_action :dish_one,:only=>[:update,:destroy]
	before_action :dish_all,:only=>[:index,:update,:draft]

	#GET /dishes/
	def index
		@dishes=@dishes.where(:status=>2)

		if current_user
			if params[:id]
				dish_one
			else
				@dish=Dish.new
			end
		end
	end

	#GET /dishes/new
	# def new
	# 	@dish=Dish.new
	# end
	#GET /dishes/faverite_list
	def faverite_list
		if params[:id]
			user_id=params[:id]
		else
			user_id=current_user.id
		end
		@user=User.find(user_id)
		@dishes=@user.dishes
	end
	#GET /dishes/draft
	def draft
		@dishes=@dishes.where(:status=>1)
		render :action=>:index
	end

	#POST /dishes/
	def create
		@dish=Dish.new(dish_params.merge(:user_id => current_user.id))
		#@dish=Dish.new
		#@dish[:user_id]=current_user.id
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

	#POST /dishes/faverite
	def faverite
		if UserDishship.exists?(:dish_id=>params[:dish_id],:user_id=>current_user.id)
			@dish=UserDishship.where(:dish_id=>params[:dish_id],:user_id=>current_user.id)
			@dish.delete_all
		else
			@dish=UserDishship.new(:dish_id=>params[:dish_id],:user_id=>current_user.id)
			@dish.save
		end
		#render :html=>UserDishship.exists?(:dish_id=>params[:dish_id],:user_id=>current_user.id)
		redirect_to dishes_path
	end
	def dish_one
		if current_user and @dish.user_id==current_user.id
			@dish=Dish.find_by_id(params[:id])
		end


	end
	def dish_all
		# users = User.joins("LEFT JOIN tickets ON users.id = tickets.user_id").select("users.*, count(tickets.id) as ticket_count").group("users.id")
		# users.first.ticket_count

		# @dish_count=Comment.group(:dish_id).count()

		@dishes=Dish.joins("LEFT JOIN comments ON dishes.id=comments.dish_id").select("dishes.*,count(comments.id) as comment_count,max(comments.updated_at) as comment_updated").group("dishes.id")

		if ['name','price','comment_countd','comment_updated'].include?params[:order]
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

	def dish_params
		params.require(:dish).permit(:name,:price,:short_des,:user_id,:status,:tag_ids=>[])
	end

end
