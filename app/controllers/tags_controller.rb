class TagsController < ApplicationController
before_filter :require_user
  def index
		@tags = @current_user.tags.find(:all)

		respond_to do |format|
		  format.html # index.html.erb
		  format.xml  { render :xml => @tags }
		end
	end
	
	def new
		@tag = @current_user.tags.new
    
		respond_to do |format|
		  format.html # new.html.erb
		  format.xml  { render :xml => @tag }
		end
	end
	
	def create
		@tag = @current_user.tags.build(params[:tag])

		respond_to do |format|
		  if @tag.save
			flash[:notice] = 'Tag was successfully created.'
			format.html { redirect_to(tags_path) }
			format.xml  { render :xml => @tag, :status => :created, :location => @tag }
		  else
			format.html { render :action => "new" }
			format.xml  { render :xml => @tag.errors, :status => :unprocessable_entity }
		  end
		end
	end

	def edit
		@tag = @current_user.tags.find(params[:id])
		
		respond_to do |format|
		  format.html 
		  format.iphone  { render :layout => false }
		  format.xml  { render :xml => @tag }
		end
	end
	
	def update
		@tag = @current_user.tags.find(params[:id])

		respond_to do |format|
		  if @tag.update_attributes(params[:tag])
			flash[:notice] = 'Tag was successfully updated.'
			format.html { redirect_to(tags_path) }
			format.xml  { head :ok }
		  else
			format.html { render :action => "edit" }
			format.xml  { render :xml => @tag.errors, :status => :unprocessable_entity }
		  end
		end
	end
	
	
	
    def destroy
		@tags = @current_user.tags.find(params[:id])
		@tags.destroy

		respond_to do |format|
		  format.html { redirect_to(tags_url) }
		  format.xml  { head :ok }
		end
	end
  
end
