class DishesController < ApplicationController

	before_action :authenticate_user!, :except => [:index]

	before_action :get_dish, :only=>[:update,:destroy]
	before_action :get_dishs, :only=>[:index,:update,:draft]

	#GET /dishes/
	def index
		@dishes = @dishes.where(:status=>:posted)

		if current_user && params[:id]
			get_dish
		else
			@dish = Dish.new
		end
	end

	#GET /dishes/faverite_list
	def faverite_list
		if params[:id]
			@dishes = User.find(params[:id]).faverites
		else
			@dishes = current_user.faverites
		end
	end

	#GET /dishes/draft
	def draft
		@dishes= current_user.dishes.page(params[:page]).per(10).where(:status=>:draft)
		render :action=>:index
	end

	#POST /dishes/
	def create
		@dish=Dish.new(dish_params)
		@dish.user = current_user

		if @dish.save
			redirect_to dishes_path
		else
			render :action=>:new
		end
	end

	#Patch /dishes/:id/
	def update
		if params[:_remove_reailpic]=='1'
			@dish.realpic=nil
		end

		if @dish.update(dish_params)
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

	#POST /dishes/faverite
	def faverite
		ship = current_user.user_dishships.find_by_dish_id( params[:id] )

		if ship
			ship.destroy
			render json:{ "status": 'unfaverite'}

		else
			@dish = current_user.user_dishships.new( :dish_id => params[:id] )
			@dish.save
			render json:{ "status": 'faverite'}
		end

	end

	def get_dish
		@dish = current_user.dishes.find(params[:id])
	end

	def get_dishs
		@dishes = Dish.all

		if ['name','price','comments_count','last_commented_at'].include?( params[:order] )
			sort_by = "#{params[:order]} DESC"
		else
			sort_by = "id DESC"
		end

		@dishes=@dishes.order(sort_by)
		@dishes=@dishes.page(params[:page]).per(10)
	end

	def dish_params
		params.require(:dish).permit(:name,:price,:short_des,:user_id,:status,:realpic,:tag_ids=>[])
	end

end
