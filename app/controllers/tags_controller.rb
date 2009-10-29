class TagsController < ApplicationController
before_filter :require_user
  def index
		@tags = @current_user.tags.find(:all)

		respond_to do |format|
		  format.html # index.html.erb
		end
	end
	
	def new
		@tag = @current_user.tags.new
    
		respond_to do |format|
		  format.html # new.html.erb
		end
	end
	
	def create
		@tag = @current_user.tags.build(params[:tag])

		respond_to do |format|
		  if @tag.save
			flash[:notice] = 'Tag was successfully created.'
			format.html { redirect_to(tags_path) }
		  else
			format.html { render :action => "new" }
		  end
		end
	end

	def edit
		@tag = @current_user.tags.find_by_id(params[:id])
		if @tag
			respond_to do |format|
			  format.html 
			  format.iphone  { render :layout => false }
			end
		else
			redirect_to(tags_path)
		end
	end
	
	def update
		@tag = @current_user.tags.find_by_id(params[:id])
		if @tag
			respond_to do |format|
			  if @tag.update_attributes(params[:tag])
				flash[:notice] = 'Tag was successfully updated.'
				format.html { redirect_to(tags_path) }
			  else
				format.html { render :action => "edit" }
			  end
			end
		else
			redirect_to(tags_path)
		end
	end
	
	
	
    def destroy
		@tags = @current_user.tags.find_by_id(params[:id])
		if @tag
			@tags.destroy

			respond_to do |format|
			  format.html { redirect_to(tags_url) }
			end
		else
			redirect_to(tags_path)
		end			
	end
  
end
