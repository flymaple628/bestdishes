class Admin::TagsController < ApplicationController
	#GET/admin/tags/:id
	def index
		# @tag=Tag.new
		if(params[:id].nil?)
			@tag=Tag.new
		else
			@tag=Tag.find(params[:id])
		end
		#render :html=>@tag.inspect
		@tags=Tag.all
	end

	#POST /admin/tags/
	def create
		#####
		@tag=Tag.new(tag_params)
		@tag.save()
		#render :text=>params
		redirect_to admin_tags_path
	end
	#PATCH /admin/tags/:id
	def update
		@tag=Tag.find(params[:id])
		@tag.update(tag_params)

		redirect_to admin_tags_path
	end
	#DELETE /admin/tags/:id
	def destroy
		if DishTagsship.exists?(tag_id:params[:id])
		flash[:notice] = "Tag already been used"
		@tags=Tag.all
		@tag=Tag.new()
		render :action=>:index
		else
		@tag=Tag.find(params[:id])
		@tag.destroy()
		redirect_to admin_tags_path
		end
	end

	def tag_params
			params.require(:tag).permit(:name)
	end
end
