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
		respond_to do |format|
			format.html {redirect_to dishes_path}
			format.js {render :text=>("$('#main-list#{params[:id]}').html('');")}
		end

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
	#POST /dishes/:id/like
	def like
		@ship = current_user.dish_likes.find_by_dish_id( params[:id] )
		@dish=Dish.find(params[:id])
		if @ship
			@ship.destroy
			@dish.like_count-=1
			#render json:{ "status": 'unfaverite'}

		else
			@dish.like_count+=1
			@dish = current_user.dish_likes.new( :dish_id => params[:id] )
			@dish.save
			#render json:{ "status": 'faverite'}
		end
		if DishLike.exists?(:dish_id=>params[:id])
			@dish_count=DishLike.where(:dish_id=>params[:id]).count
		else
			@dish_count=0
		end
		respond_to do |format|
			format.html {redirect_to :back}
			format.js

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

		if Tag.select(:id).include?params[:tag]
			@dishes=@dishes.joins(:dish_tagsships).where("tag_id=#{params[:tag]}")
		end

		@dishes=@dishes.order(sort_by)
		@dishes=@dishes.page(params[:page]).per(10)
	end

	def dish_params
		params.require(:dish).permit(:name,:price,:short_des,:user_id,:status,:realpic,:tag_name,:tag_ids=>[])
	end

end
